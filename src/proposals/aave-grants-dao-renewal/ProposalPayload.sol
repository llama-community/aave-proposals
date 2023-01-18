// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.17;

import {AaveMisc} from "@aave-address-book/AaveMisc.sol";
import {AaveV2Ethereum} from "@aave-address-book/AaveV2Ethereum.sol";

/**
 * @title AAVE Grants DAO Renewal
 * @author Llama
 * @notice This proposal approves the AGD multisig to spend the approved amount
 * Governance Forum Post: https://governance.aave.com/t/updated-proposal-aave-grants-dao-renewal/11289
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x194b68a5319b074065e38fcb0bd96e8e8b6ce15870844593e79750605a609109
 */
contract ProposalPayload {
    address public constant AGD_MULTISIG = 0x89C51828427F70D77875C6747759fB17Ba10Ceb0;
    address public constant AAVE = 0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9;
    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public constant aDAI = 0x028171bCA77440897B824Ca71D1c56caC55b68A3;
    address public constant aUSDT = 0x71fc860F7D3A592A4a98740e39dB31d25db65ae8;

    uint256 public constant AMOUNT_DAI = 451_916_320000000000000000; // $451,916.32
    uint256 public constant AMOUNT_ADAI = 1_172_938_790000000000000000; // $1,172,938.79
    uint256 public constant AMOUNT_AUSDT = 812_944_900000; // $812,944.90

    // Avg. AAVE price 12/16/2022 - 1/17/2023: 60.89
    // $812,500 / 60.89 = 13,343.734603383100000000 AAVE
    uint256 public constant AMOUNT_AAVE = 13343734603383100000000;

    /// @notice The AAVE governance executor calls this function to implement the proposal.
    function execute() external {
        AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(AaveMisc.ECOSYSTEM_RESERVE, AAVE, AGD_MULTISIG, AMOUNT_AAVE);
        AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(AaveV2Ethereum.COLLECTOR, DAI, AGD_MULTISIG, AMOUNT_DAI);
        AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(AaveV2Ethereum.COLLECTOR, aDAI, AGD_MULTISIG, AMOUNT_ADAI);
        AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(AaveV2Ethereum.COLLECTOR, aUSDT, AGD_MULTISIG, AMOUNT_AUSDT);
    }
}
