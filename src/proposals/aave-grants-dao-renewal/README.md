# AAVE Grants DAO Distribution

This repository contains the payload to approve AGD to use funds as specified in the following proposal:
https://governance.aave.com/t/updated-proposal-aave-grants-dao-renewal/11289/6

The function that approves this funds is:

```
/// @notice The AAVE governance executor calls this function to implement the proposal.
    function execute() external {
        AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(AaveMisc.ECOSYSTEM_RESERVE, AAVE, AGD_MULTISIG, AMOUNT_AAVE);
        AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(AaveV2Ethereum.COLLECTOR, DAI, AGD_MULTISIG, AMOUNT_DAI);
        AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(AaveV2Ethereum.COLLECTOR, aDAI, AGD_MULTISIG, AMOUNT_ADAI);
        AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(AaveV2Ethereum.COLLECTOR, aUSDT, AGD_MULTISIG, AMOUNT_AUSDT);
    }
```

The AGD multisig can then use these funds when they see fit.
