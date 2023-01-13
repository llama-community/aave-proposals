// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.17;

// testing libraries
import "@forge-std/Test.sol";

// contract dependencies
import {GovHelpers} from "@aave-helpers/GovHelpers.sol";
import {AaveMisc} from "@aave-address-book/AaveMisc.sol";
import {AaveV2Ethereum} from "@aave-address-book/AaveV2Ethereum.sol";
import {ProposalPayload} from "../../../proposals/aave-grants-dao-renewal/ProposalPayload.sol";
import {DeployMainnetProposal} from "../../../../script/DeployMainnetProposal.s.sol";
import {IERC20} from "@openzeppelin/token/ERC20/IERC20.sol";

contract ProposalPayloadE2ETest is Test {
    ProposalPayload public payload;
    uint256 public proposalId;

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("mainnet"), 16399698);

        payload = new ProposalPayload();

        vm.prank(GovHelpers.AAVE_WHALE);
        proposalId = DeployMainnetProposal._deployMainnetProposal(
            address(payload),
            0x78ce0d63ca0c186ca3f58e712d3f1861ced3dad15ce3ad4f0e005d1663b49caf
        );
    }

    function testExecute() public {
        assertEq(IERC20(payload.AAVE()).allowance(AaveMisc.ECOSYSTEM_RESERVE, payload.AGD_MULTISIG()), 0);
        assertEq(IERC20(payload.DAI()).allowance(AaveV2Ethereum.COLLECTOR, payload.AGD_MULTISIG()), 0);
        assertEq(IERC20(payload.aDAI()).allowance(AaveV2Ethereum.COLLECTOR, payload.AGD_MULTISIG()), 0);
        assertEq(IERC20(payload.aUSDT()).allowance(AaveV2Ethereum.COLLECTOR, payload.AGD_MULTISIG()), 0);

        GovHelpers.passVoteAndExecute(vm, proposalId);

        assertEq(
            IERC20(payload.AAVE()).allowance(AaveMisc.ECOSYSTEM_RESERVE, payload.AGD_MULTISIG()),
            payload.AMOUNT_AAVE()
        );
        assertEq(
            IERC20(payload.DAI()).allowance(AaveV2Ethereum.COLLECTOR, payload.AGD_MULTISIG()),
            payload.AMOUNT_DAI()
        );
        assertEq(
            IERC20(payload.aDAI()).allowance(AaveV2Ethereum.COLLECTOR, payload.AGD_MULTISIG()),
            payload.AMOUNT_ADAI()
        );
        assertEq(
            IERC20(payload.aUSDT()).allowance(AaveV2Ethereum.COLLECTOR, payload.AGD_MULTISIG()),
            payload.AMOUNT_AUSDT()
        );
    }
}
