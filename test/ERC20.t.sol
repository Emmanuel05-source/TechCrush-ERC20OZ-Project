// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Test} from "../lib/forge-std/src/Test.sol";
import {ERC20OZ} from "../src/ERC20.sol";

contract ERC20OZTest is Test {
    ERC20OZ public token;

    address owner;
    address user1;
    address user2;

    function setUp() public {
        owner = address(this); // test contract is owner
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");

        token = new ERC20OZ("MyToken", "MTK");
    }

    //Test name
    function testNameIsCorrect() public view {
        assertEq(token.name(), "MyToken");
    }

    //Test symbol
    function testSymbolIsCorrect() public view {
        assertEq(token.symbol(), "MTK");
    }

    //Test decimals (default is 18)
    function testDecimals() public view {
        assertEq(token.decimals(), 18);
    }

    //Test total supply
    function testTotalSupply() public view {
        uint256 expectedSupply = 1000000000e15 + 10000000;
        assertEq(token.totalSupply(), expectedSupply);
    }

    //Transfer from contract to address
    function testTransferFromContractToUser() public {
        uint256 amount = 1e18;

        // transfer from contract (owner controls it)
        token.transfer(user1, amount);

        assertEq(token.balanceOf(user1), amount);
    }

    //Transfer from one address to another
    function testTransferFromUserToUser() public {
        uint256 amount = 1e18;

        // first send tokens to user1
        token.transfer(user1, amount);

        // simulate user1 sending to user2
        vm.prank(user1);
        token.transfer(user2, amount);

        assertEq(token.balanceOf(user2), amount);
    }

    //Test mint function
    function testMint() public {
        uint256 amount = 5000;

        token.mint(amount, user1);

        assertEq(token.balanceOf(user1), amount);
    }

    //Test burn function
    function testBurn() public {
        uint256 initialBalance = token.balanceOf(address(this));
        uint256 burnAmount = 1000;

        token.burn(burnAmount);

        uint256 finalBalance = token.balanceOf(address(this));

        assertEq(finalBalance, initialBalance - burnAmount);
    }
}
