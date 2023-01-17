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

## Installation

It requires [Foundry](https://github.com/gakonst/foundry) installed to run. You can find instructions here [Foundry installation](https://github.com/gakonst/foundry#installation).

### GitHub template

It's easiest to start a new project by clicking the ["Use this template"](https://github.com/llama-community/aave-governance-forge-template).

Then clone the templated repository locally and `cd` into it and run the following commands:

```sh
$ npm install
$ forge install
$ forge update
$ git submodule update --init --recursive
```

### Manual installation

If you want to create your project manually, run the following commands:

```sh
$ forge init --template https://github.com/llama-community/aave-governance-forge-template <my-repo>
$ cd <my-repo>
$ npm install
$ forge install
$ forge update
$ git submodule update --init --recursive
```

## Setup

Duplicate `.env.example` and rename to `.env`:

- Add a valid mainnet URL for an Ethereum JSON-RPC client for the `RPC_MAINNET_URL` variable.
- Add a valid Private Key for the `PRIVATE_KEY` variable.
- Add a valid Etherscan API Key for the `ETHERSCAN_API_KEY` variable.

### Commands

- `make build` - build the project
- `make test [optional](V={1,2,3,4,5})` - run tests (with different debug levels if provided)
- `make match MATCH=<TEST_FUNCTION_NAME> [optional](V=<{1,2,3,4,5}>)` - run matched tests (with different debug levels if provided)

### Deploy and Verify

- `make deploy-payload` - deploy and verify payload on mainnet
- `make deploy-proposal`- deploy proposal on mainnet

To confirm the deploy was successful, re-run your test suite but use the newly created contract address.
