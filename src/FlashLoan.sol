// contracts/FlashLoan.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {FlashLoanSimpleReceiverBase} from "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {IERC20} from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract FlashLoan is FlashLoanSimpleReceiverBase {
    address payable public owner;

    constructor(address provider) FlashLoanSimpleReceiverBase(IPoolAddressesProvider(provider)) {
        owner = payable(msg.sender);
    }

    /**
     * This function is called after your contract has received the flash loaned amount
     */
    function executeOperation(address asset, uint256 amount, uint256 premium, address initiator, bytes calldata params)
        external
        override
        returns (bool)
    {
        //
        // This contract now has the funds requested.
        // Your logic goes here.
        //

        // At the end of your logic above, this contract owes
        // the flashloaned amount + premiums.
        // Therefore ensure your contract has enough to repay
        // these amounts.

        // Approve the Pool contract allowance to *pull* the owed amount
        uint256 amountOwed = amount + premium;
        IERC20(asset).approve(address(POOL), amountOwed);

        return true;
    }

    function requsetFlashLoan(address asset, uint256 amount) public {
        address receiver = address(this);
        bytes memory params = "";
        uint16 referralCode = 0;

        POOL.flashLoanSimple(receiver, asset, amount, params, referralCode);
    }

    function getBalance(address asset) public view returns (uint256) {
        return IERC20(asset).balanceOf(address(this));
    }

    function withdraw(address asset) public {
        require(msg.sender == owner, "Only owner can withdraw");
        IERC20(asset).transfer(owner, IERC20(asset).balanceOf(address(this)));
    }

    receive() external payable {}
}
