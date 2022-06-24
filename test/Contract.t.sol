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

        uint256 _level0 = maskContract.getLevelA(0);
        uint256 _level1 = maskContract.getLevelB(0);
        uint256 _level2 = maskContract.getLevelC(0);

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

    function testLevelAIncrease() public {
        uint256 _level0 = maskContract.getLevelA(0);

        assertEq(
            _level0,
            0
        );

        maskContract.increaseLevelA(0);
        _level0 = maskContract.getLevelA(0);

        assertEq(
            _level0,
            1
        );
    }

    function testLevelABIncrease() public {
        uint256 _level0 = maskContract.getLevelA(0);

        assertEq(
            _level0,
            0
        );

        maskContract.increaseLevelA(0);
        _level0 = maskContract.getLevelA(0);

        assertEq(
            _level0,
            1
        );

        uint256 _level1 = maskContract.getLevelB(0);
        assertEq(
            _level1,
            0
        );

        maskContract.increaseLevelB(0);
        _level1 = maskContract.getLevelB(0);

        assertEq(
            _level0,
            1
        );
    }
}
