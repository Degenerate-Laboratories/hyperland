# HyperLand Assessor Registry & Valuation System

**Version**: 1.0
**Last Updated**: November 21, 2025
**Status**: ✅ Implemented & Tested

---

## 📋 Overview

The Assessor Registry System enables **third-party property assessors** to submit professional land valuations for HyperLand parcels, subject to admin approval. This creates a transparent, auditable, and decentralized valuation mechanism.

### Key Features
- ✅ **Admin-Approved Assessor Registry** - Only certified assessors can submit valuations
- ✅ **Valuation History Tracking** - Complete audit trail for all assessments
- ✅ **Multi-Source Pricing** - Multiple assessors can value the same parcel
- ✅ **Admin Approval Workflow** - All valuations require admin review before activation
- ✅ **Rate Limiting** - Prevents spam valuations (1 per parcel per day)
- ✅ **Value Change Constraints** - Protects against manipulation (max 5x increase/decrease)

---

## 🏗️ Architecture

### System Components

```
┌─────────────────────────────────────────────────────────┐
│              Admin (Contract Owner)                      │
│  - Register/revoke assessors                            │
│  - Approve/reject valuations                            │
│  - Configure system parameters                          │
└──────────────────┬──────────────────────────────────────┘
                   │
    ┌──────────────┴──────────────┐
    ▼                             ▼
┌──────────────────┐     ┌─────────────────────┐
│ Assessor Registry│     │ Valuation Workflow   │
│                  │     │                      │
│ - Active status  │     │ 1. Submit valuation  │
│ - Credentials    │     │ 2. Admin reviews     │
│ - Assessment cnt │     │ 3. Approve/reject    │
│ - Registered at  │     │ 4. Update parcel     │
└──────────────────┘     └─────────────────────┘
                                  │
                                  ▼
                   ┌──────────────────────────┐
                   │  Valuation History       │
                   │  - All submissions       │
                   │  - Approval status       │
                   │  - Methodology notes     │
                   │  - Timestamp tracking    │
                   └──────────────────────────┘
```

---

## 📊 Data Structures

### Assessor

```solidity
struct Assessor {
    bool isActive;              // Can submit valuations
    uint256 registeredAt;       // Registration timestamp
    uint256 assessmentCount;    // Total assessments submitted
    string credentials;         // IPFS hash to certification docs
}
```

### AssessedValue

```solidity
struct AssessedValue {
    uint256 value;              // Proposed value in LAND tokens
    address assessor;           // Who submitted this
    uint256 timestamp;          // When submitted
    string methodology;         // How value was determined
    bool approved;              // Admin approval status
}
```

---

## 🔧 Core Functions

### Admin Functions

#### Register Assessor
```solidity
function registerAssessor(address assessor, string calldata credentials) external onlyOwner
```
- **Purpose**: Add new certified assessor to registry
- **Parameters**:
  - `assessor`: Ethereum address of assessor
  - `credentials`: IPFS hash or URI to certification documents
- **Requirements**: Must be called by contract owner
- **Emits**: `AssessorRegistered(address, uint256, string)`

#### Revoke Assessor
```solidity
function revokeAssessor(address assessor) external onlyOwner
```
- **Purpose**: Remove assessor's submission privileges
- **Effect**: Assessor can no longer submit new valuations
- **Emits**: `AssessorRevoked(address, uint256)`

### Assessor Functions

#### Submit Valuation
```solidity
function submitValuation(
    uint256 parcelId,
    uint256 proposedValue,
    string calldata methodology
) external
```
- **Purpose**: Submit property assessment for review
- **Requirements**:
  - Must be approved assessor
  - Parcel must be initialized
  - Value must be within allowed ranges
  - Cannot submit more than once per day per parcel
- **Constraints**:
  - Max increase: 5x current value (configurable)
  - Max decrease: 80% (1/5x configurable)
  - Min interval: 1 day (configurable)
- **Emits**: `ValuationSubmitted(uint256, address, uint256, uint256, string)`

### Admin Review Functions

#### Approve Valuation
```solidity
function approveValuation(uint256 parcelId, uint256 valueIndex) external onlyOwner
```
- **Purpose**: Approve pending valuation and update parcel value
- **Effect**: Sets parcel's assessed value to approved amount
- **Emits**: `ValuationApproved(uint256, uint256, address)`, `AssessedValueUpdated(uint256, uint256, uint256)`

#### Reject Valuation
```solidity
function rejectValuation(
    uint256 parcelId,
    uint256 valueIndex,
    string calldata reason
) external onlyOwner
```
- **Purpose**: Reject pending valuation with explanation
- **Note**: Does not delete valuation from history
- **Emits**: `ValuationRejected(uint256, uint256, address, string)`

---

## 🔍 View Functions

### Check Assessor Status
```solidity
function isApprovedAssessor(address assessor) external view returns (bool)
```
Returns whether address is currently an active assessor.

### Get Assessor Info
```solidity
function getAssessorInfo(address assessor) external view returns (Assessor memory)
```
Returns complete assessor profile.

### Get Valuation History
```solidity
function getValuationHistory(uint256 parcelId) external view returns (AssessedValue[] memory)
```
Returns all valuations ever submitted for a parcel.

### Get Pending Valuations
```solidity
function getPendingValuations(uint256 parcelId) external view returns (AssessedValue[] memory)
```
Returns only unapproved valuations awaiting admin review.

---

## ⚙️ Configuration

### Valuation Constraints
```solidity
function setValuationConstraints(
    uint256 maxIncrease,
    uint256 maxDecrease,
    uint256 minInterval
) external onlyOwner
```

**Default Values**:
- Max increase multiplier: **5x** (can increase value up to 5x current)
- Max decrease multiplier: **5x** (can decrease value to 1/5x current = 80% decrease)
- Min valuation interval: **1 day**

**Valid Ranges**:
- Multipliers: 2-20
- Interval: 1 hour - 30 days

---

## 📝 Usage Workflows

### Workflow 1: Register New Assessor

```javascript
// 1. Admin registers certified assessor
await core.registerAssessor(
  "0x123...abc",
  "ipfs://Qm...credentials"
);

// 2. Verify registration
const isApproved = await core.isApprovedAssessor("0x123...abc");
console.log(isApproved); // true

// 3. Get assessor details
const info = await core.getAssessorInfo("0x123...abc");
console.log(info.assessmentCount); // 0 (new assessor)
```

### Workflow 2: Submit & Approve Valuation

```javascript
// 1. Assessor submits valuation
await core.connect(assessor).submitValuation(
  parcelId,          // Token ID
  1200n * 10n**18n,  // 1200 LAND tokens
  "comparable_sales" // Methodology
);

// 2. Check pending valuations
const pending = await core.getPendingValuations(parcelId);
console.log(pending.length); // 1

// 3. Admin reviews and approves
await core.connect(admin).approveValuation(
  parcelId,
  0  // Index in valuation history
);

// 4. Parcel value updated
const parcelState = await core.parcelStates(parcelId);
console.log(parcelState.assessedValueLAND); // 1200 * 10^18
```

### Workflow 3: Reject Valuation

```javascript
// Admin rejects with reason
await core.connect(admin).rejectValuation(
  parcelId,
  0,  // Value index
  "Methodology not adequately documented"
);

// Valuation remains in history but not approved
const history = await core.getValuationHistory(parcelId);
console.log(history[0].approved); // false
```

---

## 🔐 Security Considerations

### Access Control
| Function | Owner | Assessor | Anyone |
|----------|-------|----------|--------|
| `registerAssessor()` | ✅ | ❌ | ❌ |
| `revokeAssessor()` | ✅ | ❌ | ❌ |
| `submitValuation()` | ❌ | ✅ | ❌ |
| `approveValuation()` | ✅ | ❌ | ❌ |
| `rejectValuation()` | ✅ | ❌ | ❌ |
| `setValuationConstraints()` | ✅ | ❌ | ❌ |

### Rate Limiting
- **Per Parcel**: Maximum 1 valuation per day per parcel (any assessor)
- **Purpose**: Prevent spam and manipulation
- **Bypass**: First valuation has no rate limit

### Value Change Protection
- **Maximum Increase**: 5x current value (prevents pump schemes)
- **Maximum Decrease**: 80% decrease (prevents dump schemes)
- **Admin Override**: Admin can use `setAssessedValue()` directly (legacy method)

### Audit Trail
- **Immutable History**: All valuations stored permanently
- **Timestamp Tracking**: Exact submission time recorded
- **Methodology Documentation**: Required for transparency
- **Approver Tracking**: Events log who approved/rejected

---

## 🎯 Use Cases

### 1. Professional Real Estate Assessor
A certified property assessor evaluates HyperLand parcels based on:
- Comparable sales in adjacent parcels
- Location desirability (proximity to center, landmarks)
- Parcel size and shape
- Historical auction results

**Workflow**:
1. Register with credentials (real estate license, certifications)
2. Submit valuations with detailed methodology
3. Admin reviews credentials and methodology
4. Approved valuations become official assessed values

### 2. Automated Oracle Service
A service that aggregates multiple data sources:
- Recent marketplace sales
- Auction closing prices
- External real estate APIs
- Machine learning price predictions

**Workflow**:
1. Register oracle contract as assessor
2. Oracle submits valuations automatically
3. Admin reviews oracle accuracy over time
4. High-quality oracles get auto-approval (future feature)

### 3. Community DAO Governance (Future)
Transition assessor approval to DAO voting:
1. Assessor applicants stake tokens
2. Token holders vote on assessor approval
3. Valuations go through multi-sig approval
4. Slashing for consistently inaccurate assessments

---

## 📈 Integration with Existing Systems

### Tax System
- Taxes calculated from `assessedValueLAND`
- Approved valuations update assessed value
- Tax obligations recalculated automatically

### Auction System
- Minimum bids based on assessed value (10%)
- Auction results can inform future valuations
- Market-clearing prices feed back to assessors

### Marketplace
- Assessed value provides pricing guidance
- Listing prices compared to assessed value
- Over/under-valued parcels identified

---

## 🚀 Deployment Guide

### Prerequisites
1. HyperLandCore contract deployed
2. Admin wallet with owner permissions
3. Assessor candidates identified

### Step 1: Register Assessors
```bash
# Register first assessor
cast send $CORE_ADDRESS \
  "registerAssessor(address,string)" \
  0x123...abc \
  "ipfs://QmCredentials123" \
  --rpc-url base \
  --private-key $ADMIN_KEY
```

### Step 2: Configure Constraints (Optional)
```bash
# Set custom constraints
cast send $CORE_ADDRESS \
  "setValuationConstraints(uint256,uint256,uint256)" \
  10 \    # 10x max increase
  10 \    # 10x max decrease
  86400 \ # 1 day interval
  --rpc-url base \
  --private-key $ADMIN_KEY
```

### Step 3: Monitor Submissions
```bash
# Get pending valuations for review
cast call $CORE_ADDRESS \
  "getPendingValuations(uint256)(tuple[])" \
  1 \
  --rpc-url base
```

---

## 🧪 Testing

### Test Coverage
- ✅ 36 comprehensive test cases
- ✅ 100% function coverage
- ✅ Edge case validation
- ✅ Access control verification
- ✅ Integration testing

### Run Tests
```bash
forge test --match-contract AssessorRegistryTest -vv
```

### Test Categories
1. **Assessor Registration** (6 tests)
2. **Assessor Revocation** (4 tests)
3. **Valuation Submission** (12 tests)
4. **Valuation Approval** (6 tests)
5. **Valuation Rejection** (3 tests)
6. **View Functions** (3 tests)
7. **Configuration** (2 tests)

---

## 🔮 Future Enhancements

### Phase 2: Oracle Integration
```solidity
interface IPropertyOracle {
    function getPropertyValue(uint256 parcelId)
        external view returns (uint256 value, uint256 confidence);
}
```
- Chainlink integration for market data
- Multi-oracle aggregation
- Confidence-weighted averaging

### Phase 3: DAO Governance
- Token-weighted assessor approval voting
- Multi-signature valuation approval
- Slashing mechanism for bad assessors
- Reputation scoring system

### Phase 4: Automated Valuation Models (AVM)
- Machine learning price predictions
- Neighbor-based pricing (adjacent parcels)
- Historical trend analysis
- Market sentiment integration

---

## 📊 Event Reference

```solidity
event AssessorRegistered(address indexed assessor, uint256 timestamp, string credentials);
event AssessorRevoked(address indexed assessor, uint256 timestamp);
event ValuationSubmitted(uint256 indexed parcelId, address indexed assessor, uint256 value, uint256 timestamp, string methodology);
event ValuationApproved(uint256 indexed parcelId, uint256 valueIndex, address indexed approver);
event ValuationRejected(uint256 indexed parcelId, uint256 valueIndex, address indexed approver, string reason);
event AssessedValueUpdated(uint256 indexed parcelId, uint256 oldValue, uint256 newValue);
```

---

## 📞 Support & Questions

**Documentation**: `/docs/ASSESSOR_SYSTEM.md`
**Contract**: `/contracts/src/HyperLandCore.sol`
**Tests**: `/contracts/test/AssessorRegistry.t.sol`
**Issues**: GitHub Issues

---

**Last Updated**: November 21, 2025
**Version**: 1.0
**Status**: Production Ready ✅
