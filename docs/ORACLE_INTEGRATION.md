# HyperLand Oracle Integration Architecture

**Version**: 1.0 (Future Enhancement)
**Status**: 🔄 Design Complete - Implementation Pending
**Priority**: Phase 3

---

## 📋 Overview

Oracle integration will enable HyperLand to incorporate **external market data** into property valuations, creating a more dynamic and market-responsive pricing system.

### Goals
- 🎯 **Automated Valuations**: Reduce manual assessment overhead
- 🎯 **Market-Responsive Pricing**: Reflect real-time market conditions
- 🎯 **Multi-Source Aggregation**: Combine data from multiple oracles for accuracy
- 🎯 **Confidence Scoring**: Weight valuations by reliability
- 🎯 **Decentralized Pricing**: Reduce single point of failure in valuations

---

## 🏗️ Architecture

### System Design

```
┌──────────────────────────────────────────────────────────┐
│                  HyperLandCore                           │
│                                                          │
│  ┌────────────────────────────────────────────────────┐ │
│  │        Assessor Registry System (Current)          │ │
│  │  - Manual assessor submissions                     │ │
│  │  - Admin approval workflow                         │ │
│  └────────────────────────────────────────────────────┘ │
│                                                          │
│  ┌────────────────────────────────────────────────────┐ │
│  │     Oracle Integration Layer (Future)              │ │
│  │                                                     │ │
│  │  propertyOracle: IPropertyOracle                   │ │
│  │                                                     │ │
│  │  submitOracleValuation(parcelId)                   │ │
│  │   ├─ Query oracle for value                        │ │
│  │   ├─ Check confidence threshold (≥70%)             │ │
│  │   ├─ Create pending valuation                      │ │
│  │   └─ Await admin approval                          │ │
│  └────────────────────────────────────────────────────┘ │
└────────────┬─────────────────────────────────────────────┘
             │
   ┌─────────┴──────────┐
   ▼                    ▼
┌──────────────┐  ┌──────────────────┐
│   Oracle 1   │  │    Oracle 2      │
│  (Chainlink) │  │  (Custom API)    │
│              │  │                  │
│ - Market     │  │ - Sales comps    │
│   data       │  │ - Location data  │
│ - Auction    │  │ - ML predictions │
│   results    │  │                  │
└──────────────┘  └──────────────────┘
```

---

## 📜 IPropertyOracle Interface

```solidity
interface IPropertyOracle {
    /**
     * @dev Get property valuation for a specific parcel
     * @param parcelId Token ID of the parcel
     * @return value Assessed value in LAND tokens
     * @return confidence Confidence score (0-100)
     */
    function getPropertyValue(uint256 parcelId)
        external
        view
        returns (uint256 value, uint256 confidence);

    /**
     * @dev Get the oracle's name/identifier
     */
    function oracleName() external view returns (string memory);

    /**
     * @dev Get the data sources used by this oracle
     */
    function dataSources() external view returns (string[] memory);

    /**
     * @dev Check if oracle can value a specific parcel
     */
    function canValueParcel(uint256 parcelId) external view returns (bool);

    /**
     * @dev Get last update timestamp for a parcel's valuation
     */
    function lastUpdated(uint256 parcelId) external view returns (uint256);
}
```

---

## 🔧 Proposed HyperLandCore Enhancements

### New State Variables

```solidity
IPropertyOracle public propertyOracle;
uint256 public minimumOracleConfidence = 70; // Minimum 70% confidence required
```

### New Admin Functions

#### Set Property Oracle
```solidity
function setPropertyOracle(address oracle) external onlyOwner {
    require(oracle != address(0), "Invalid oracle");
    propertyOracle = IPropertyOracle(oracle);
}
```

#### Configure Oracle Settings
```solidity
function setOracleConfidence(uint256 minConfidence) external onlyOwner {
    require(minConfidence >= 50 && minConfidence <= 100, "Invalid confidence");
    minimumOracleConfidence = minConfidence;
}
```

### New Public Function

#### Submit Oracle Valuation
```solidity
function submitOracleValuation(uint256 parcelId) external {
    require(address(propertyOracle) != address(0), "Oracle not set");
    require(propertyOracle.canValueParcel(parcelId), "Oracle cannot value parcel");

    (uint256 value, uint256 confidence) = propertyOracle.getPropertyValue(parcelId);
    require(confidence >= minimumOracleConfidence, "Confidence too low");
    require(value > 0, "Invalid value");
    require(value <= landToken.TOTAL_SUPPLY(), "Value exceeds supply");

    // Create pending valuation (same workflow as assessor submissions)
    valuationHistory[parcelId].push(AssessedValue({
        value: value,
        assessor: address(propertyOracle),
        timestamp: block.timestamp,
        methodology: string(abi.encodePacked(
            "oracle_",
            propertyOracle.oracleName(),
            "_confidence_",
            _uint2str(confidence)
        )),
        approved: false
    }));

    lastValuationTime[parcelId] = block.timestamp;

    emit ValuationSubmitted(parcelId, address(propertyOracle), value, block.timestamp, "oracle_automated");
}
```

---

## 🌐 Oracle Implementation Examples

### 1. Simple Admin-Controlled Oracle

**Use Case**: Testing, initial deployment, manual price setting
**File**: `contracts/src/SimplePropertyOracle.sol`

```solidity
contract SimplePropertyOracle is IPropertyOracle, Ownable {
    mapping(uint256 => ValuationData) private valuations;

    function setValuation(uint256 parcelId, uint256 value, uint256 confidence)
        external onlyOwner
    {
        valuations[parcelId] = ValuationData({
            value: value,
            confidence: confidence,
            timestamp: block.timestamp,
            exists: true
        });
    }

    function getPropertyValue(uint256 parcelId)
        external view returns (uint256, uint256)
    {
        return (valuations[parcelId].value, valuations[parcelId].confidence);
    }
}
```

### 2. Marketplace-Based Oracle

**Use Case**: Use recent marketplace sales as pricing reference
**Data Sources**: HyperLandCore marketplace listings and sales

```solidity
contract MarketplaceOracle is IPropertyOracle {
    HyperLandCore public core;
    mapping(uint256 => uint256[]) public recentSales; // parcelId => sale prices

    function getPropertyValue(uint256 parcelId)
        external view returns (uint256 value, uint256 confidence)
    {
        uint256[] memory sales = recentSales[parcelId];
        if (sales.length == 0) return (0, 0);

        // Calculate average of recent sales
        uint256 sum = 0;
        for (uint256 i = 0; i < sales.length; i++) {
            sum += sales[i];
        }

        value = sum / sales.length;
        confidence = sales.length >= 3 ? 90 : 60; // Higher confidence with more data

        return (value, confidence);
    }
}
```

### 3. Auction-Based Oracle

**Use Case**: Use auction clearing prices as market signals
**Data Sources**: Completed auction results

```solidity
contract AuctionOracle is IPropertyOracle {
    HyperLandCore public core;
    mapping(uint256 => AuctionResult) public lastAuction;

    struct AuctionResult {
        uint256 price;
        uint256 timestamp;
    }

    function getPropertyValue(uint256 parcelId)
        external view returns (uint256 value, uint256 confidence)
    {
        AuctionResult memory result = lastAuction[parcelId];

        if (result.price == 0) return (0, 0);

        // Confidence decreases with age
        uint256 age = block.timestamp - result.timestamp;
        if (age > 90 days) return (result.price, 30);
        if (age > 30 days) return (result.price, 60);
        return (result.price, 90);
    }
}
```

### 4. Neighbor-Based Oracle (Geospatial)

**Use Case**: Estimate value based on adjacent parcel values
**Data Sources**: Assessed values of neighboring parcels

```solidity
contract NeighborOracle is IPropertyOracle {
    HyperLandCore public core;
    LandDeed public deed;

    function getPropertyValue(uint256 parcelId)
        external view returns (uint256 value, uint256 confidence)
    {
        // Get parcel coordinates
        (uint256 x, uint256 y,,) = deed.getParcel(parcelId);

        // Find adjacent parcels
        uint256[] memory neighbors = findAdjacentParcels(x, y);

        if (neighbors.length == 0) return (0, 0);

        // Average neighbor values
        uint256 sum = 0;
        for (uint256 i = 0; i < neighbors.length; i++) {
            (uint256 neighborValue,,,,,) = core.parcelStates(neighbors[i]);
            sum += neighborValue;
        }

        value = sum / neighbors.length;
        confidence = neighbors.length >= 3 ? 85 : 50;

        return (value, confidence);
    }
}
```

### 5. Chainlink Functions Oracle (External API)

**Use Case**: Fetch data from external real estate APIs
**Data Sources**: Zillow, Redfin, or custom APIs

```solidity
contract ChainlinkFunctionsOracle is IPropertyOracle, FunctionsClient {
    using Functions for Functions.Request;

    string public source = `
        const parcelId = args[0];
        const apiResponse = await Functions.makeHttpRequest({
            url: \`https://api.realestate.com/parcel/\${parcelId}\`
        });
        return Functions.encodeUint256(apiResponse.data.value);
    `;

    function getPropertyValue(uint256 parcelId)
        external view returns (uint256 value, uint256 confidence)
    {
        // Return cached value from last Chainlink response
        return (cachedValues[parcelId], cachedConfidence[parcelId]);
    }

    function requestUpdate(uint256 parcelId) external {
        Functions.Request memory req;
        req.initializeRequestForInlineJavaScript(source);
        req.setArgs([Strings.toString(parcelId)]);

        _sendRequest(req.encodeCBOR(), subscriptionId, gasLimit, donID);
    }
}
```

---

## 🔄 Valuation Workflow with Oracles

### Step-by-Step Process

```
1. Anyone Calls submitOracleValuation(parcelId)
   │
   ├─ HyperLandCore queries propertyOracle
   │
   ├─ Oracle returns (value, confidence)
   │
   ├─ Check confidence >= minimumOracleConfidence (70%)
   │
   ├─ Create pending valuation in history
   │
   └─ Emit ValuationSubmitted event

2. Admin Reviews Pending Valuation
   │
   ├─ Check oracle data sources
   │
   ├─ Verify methodology sounds
   │
   └─ Decide: Approve or Reject

3. If Approved
   │
   ├─ Valuation marked as approved
   │
   ├─ Parcel assessedValueLAND updated
   │
   └─ Emit ValuationApproved & AssessedValueUpdated

4. If Rejected
   │
   ├─ Valuation remains in history
   │
   ├─ Emit ValuationRejected with reason
   │
   └─ Oracle operator can address issues
```

---

## 🎯 Multi-Oracle Aggregation Strategy

### Approach: Weighted Average with Confidence

```solidity
function aggregateOracleValues(uint256 parcelId, IPropertyOracle[] memory oracles)
    internal view returns (uint256 aggregatedValue, uint256 aggregatedConfidence)
{
    uint256 totalWeightedValue = 0;
    uint256 totalWeight = 0;

    for (uint256 i = 0; i < oracles.length; i++) {
        if (!oracles[i].canValueParcel(parcelId)) continue;

        (uint256 value, uint256 confidence) = oracles[i].getPropertyValue(parcelId);

        if (confidence >= minimumOracleConfidence) {
            uint256 weight = confidence; // Confidence acts as weight
            totalWeightedValue += value * weight;
            totalWeight += weight;
        }
    }

    if (totalWeight == 0) return (0, 0);

    aggregatedValue = totalWeightedValue / totalWeight;
    aggregatedConfidence = totalWeight / oracles.length; // Average confidence

    return (aggregatedValue, aggregatedConfidence);
}
```

---

## 📊 Confidence Scoring Guidelines

| Confidence | Data Quality | Use Case |
|-----------|--------------|----------|
| 90-100% | High quality, recent, multiple sources | Auction results <30 days, ≥3 comparable sales |
| 75-89% | Good quality, moderately recent | Auction results 30-60 days, 2 comparable sales |
| 60-74% | Acceptable quality | Single comparable sale, neighbor average |
| 50-59% | Low quality, aged data | Auction results >90 days, sparse data |
| <50% | Insufficient data | Reject - not confident enough |

**Default Minimum**: 70%

---

## 🚀 Implementation Roadmap

### Phase 1: Foundation (Current)
- ✅ Assessor registry system
- ✅ Manual valuation workflow
- ✅ Admin approval process

### Phase 2: Basic Oracle Support (Next)
- ⏳ IPropertyOracle interface
- ⏳ SimplePropertyOracle implementation
- ⏳ `submitOracleValuation()` function
- ⏳ Oracle configuration admin functions

### Phase 3: Advanced Oracles
- 📋 MarketplaceOracle (use sales data)
- 📋 AuctionOracle (use auction results)
- 📋 NeighborOracle (geospatial pricing)
- 📋 Multi-oracle aggregation

### Phase 4: External Integration
- 💡 Chainlink Functions for external APIs
- 💡 Chainlink Price Feeds for LAND/USD
- 💡 Custom oracle network
- 💡 Automated oracle approval based on track record

---

## 🔐 Security Considerations

### Oracle Trust Model
- **Admin Vetting**: All oracles must be registered by admin
- **Confidence Thresholds**: Require minimum confidence scores
- **Approval Workflow**: Oracle valuations still need admin approval
- **Circuit Breaker**: Admin can disable oracle in emergency

### Attack Vectors & Mitigations

| Attack | Mitigation |
|--------|------------|
| Malicious Oracle | Admin registration + approval workflow |
| Stale Data | `lastUpdated()` checks + age-based confidence reduction |
| Price Manipulation | Multi-oracle aggregation + outlier detection |
| Oracle Downtime | Fallback to manual assessments |
| Front-running | Rate limiting + batch updates |

---

## 📈 Testing Strategy

### Unit Tests
- ✅ Oracle interface compliance
- ✅ Confidence threshold enforcement
- ✅ Valuation submission workflow
- ✅ Admin approval/rejection

### Integration Tests
- ⏳ Multi-oracle aggregation
- ⏳ Marketplace + oracle interaction
- ⏳ Auction + oracle feedback loop
- ⏳ Tax calculation with oracle values

### Gas Optimization
- Target: <150K gas for `submitOracleValuation()`
- Batch operations for multiple parcels
- Optimize storage patterns

---

## 📚 Reference Implementation

See files:
- `contracts/src/interfaces/IPropertyOracle.sol` - Oracle interface
- `contracts/src/SimplePropertyOracle.sol` - Reference implementation
- `docs/ASSESSOR_SYSTEM.md` - Current valuation system

---

## 🎓 Developer Guide

### Implementing a Custom Oracle

```solidity
// 1. Implement IPropertyOracle
contract MyOracle is IPropertyOracle {
    function getPropertyValue(uint256 parcelId)
        external view returns (uint256 value, uint256 confidence)
    {
        // Your custom logic here
        // - Fetch from API
        // - Calculate from on-chain data
        // - Aggregate multiple sources
    }

    // Implement other required functions...
}

// 2. Deploy oracle
MyOracle oracle = new MyOracle(oracleOwner);

// 3. Register with HyperLandCore
core.setPropertyOracle(address(oracle));

// 4. Anyone can trigger oracle valuation
core.submitOracleValuation(parcelId);

// 5. Admin approves
core.approveValuation(parcelId, valueIndex);
```

---

**Status**: Design Complete - Ready for Implementation
**Next Steps**: Implement Phase 2 (Basic Oracle Support)
**Timeline**: Q1 2026

---

**Last Updated**: November 21, 2025
**Version**: 1.0 (Design)
