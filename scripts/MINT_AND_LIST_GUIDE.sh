/Users/highlander/.npm/_npx/1bf7c3c15bf47d04/node_modules/ts-node/src/index.ts:859
    return new TSError(diagnosticText, diagnosticCodes, diagnostics);
           ^
TSError: ⨯ Unable to compile TypeScript:
scripts/mint-and-list-all-parcels.ts(11,10): error TS2305: Module '"ethers"' has no exported member 'parseEther'.

    at createTSError (/Users/highlander/.npm/_npx/1bf7c3c15bf47d04/node_modules/ts-node/src/index.ts:859:12)
    at reportTSError (/Users/highlander/.npm/_npx/1bf7c3c15bf47d04/node_modules/ts-node/src/index.ts:863:19)
    at getOutput (/Users/highlander/.npm/_npx/1bf7c3c15bf47d04/node_modules/ts-node/src/index.ts:1077:36)
    at Object.compile (/Users/highlander/.npm/_npx/1bf7c3c15bf47d04/node_modules/ts-node/src/index.ts:1433:41)
    at Module.m._compile (/Users/highlander/.npm/_npx/1bf7c3c15bf47d04/node_modules/ts-node/src/index.ts:1617:30)
    at loadTS (node:internal/modules/cjs/loader:1831:10)
    at Object.require.extensions.<computed> [as .ts] (/Users/highlander/.npm/_npx/1bf7c3c15bf47d04/node_modules/ts-node/src/index.ts:1621:12)
    at Module.load (node:internal/modules/cjs/loader:1473:32)
    at Function._load (node:internal/modules/cjs/loader:1285:12)
    at TracingChannel.traceSync (node:diagnostics_channel:322:14) {
  diagnosticCodes: [ 2305 ]
}
