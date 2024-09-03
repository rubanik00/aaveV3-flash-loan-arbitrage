// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {FlashLoanArbitrage} from "src/FlashLoanArbitrage.sol";
import {Dex} from "src/Dex.sol";
import "forge-std/Script.sol";

contract FlashLoanArbitrageDeploy is Script {
    function run() external {
        address provider = 0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A;
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        Dex dex = new Dex();

        address dexAddress = address(dex);

        console.log("Contract Dex deployed at:", dexAddress);

        FlashLoanArbitrage flashLoan = new FlashLoanArbitrage(provider, dexAddress);

        vm.stopBroadcast();

        console.log("Contract FlashLoan deployed at:", address(flashLoan));
    }
}
