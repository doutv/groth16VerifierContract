// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract GnarkKeccakTest is Test {
    // test Gnark keccak = EVM keccak
    function test_keccak() public {
        bytes32 pkX = 0x28384fa79d817f1315622c0ac3b6610a9846d94892f4ac1c46caece184795bbb;
        bytes32 pkY = 0xb3e44e1f5099d5d0ed0f91ea766ea3345d1662448cc91ff9cac298ba7c5e85d9;
        bytes32 txHash = 0xb46e9123dae11187dfc5104a721e4c50d14c2ec4f111d4bb31fbc76c3ed1fa7a;
        bytes32 hashout = keccak256(abi.encodePacked(pkX, pkY, txHash));
        console.logBytes32(hashout);
        bytes32 gnarkHashout = 0x2caffed5f1399ba30181f71d8302df53322a1a46be2e3130f48718f9d0ec5607;
        assertEq(hashout, gnarkHashout, "Hash should match");
    }
}