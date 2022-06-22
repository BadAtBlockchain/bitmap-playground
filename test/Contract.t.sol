// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import 'src/Contract.sol';

contract ContractTest is Test {
    Contract maskContract;

    function setUp() public {
        maskContract = new Contract();
    }

    function testValuesStartAtZero() public {
        uint256 _level = maskContract.levels(0);
        assertEq(
            _level,
            0
        );

        uint256 _level0 = maskContract.get(0, 0);
        uint256 _level1 = maskContract.get(0, 1);
        uint256 _level2 = maskContract.get(0, 2);

        assertEq(
            _level0,
            0
        );

        assertEq(
            _level1,
            0
        );

        assertEq(
            _level2,
            0
        );
    }

}
