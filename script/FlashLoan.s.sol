// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {FlashLoan} from "src/FlashLoan.sol";
import "forge-std/Script.sol";

contract DeployContract is Script {
    function run() external {
        address provider = 0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A;
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        FlashLoan flashLoan = new FlashLoan(provider);

        vm.stopBroadcast();

        console.log("Contract FlashLoan deployed at:", address(flashLoan));
    }
}
