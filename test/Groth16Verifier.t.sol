// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Groth16Verifier} from "../src/Groth16Verifier.sol";

contract Groth16VerifierTest is Test {
    Groth16Verifier public verifier;

    function setUp() public {
        verifier = new Groth16Verifier();
    }

    function test_verify_and_increment_counter() public {
        // ["0x27cf6c553e4c37cebfbc64623e2d08e6ea6ff55913b1231cc0c25fd721abc36f", "0x24d47f57ac26b35af9787bf1115f1b9bd50ba4c49ba8f40f43c7dc66fbd96450"],[["0x2aa4ff5eb7fc06306df8353b77173ad3ece671bfa55fd12240c9509bd4ff0d51", "0x1eca26483822603fdca4056a915cd5349928e16ca457c69f7fdaca274f2a90bd"],["0x293f75f888955eeb903b7fa37d5733e8833418a97395e0facbe945ced7463a7d", "0x015940e84059ee5661f3fc38e6e2d59c161a070297dba17c5dd088a1fe8dc482"]],["0x18f3a765e7ee768a87c41c1bfab59decb3aedc34fda557174be0634eab7b12eb", "0x11d9a6e5bdd6837fccc8b0018baf2290990d996c1d4dc60766efeda2569f950d"],["0x0000000000000000000000000000000000000000000000000000000000000052","0x0000000000000000000000000000000000000000000000000000000000000005"]
        uint256[2] memory a = [
            0x27cf6c553e4c37cebfbc64623e2d08e6ea6ff55913b1231cc0c25fd721abc36f,
            0x24d47f57ac26b35af9787bf1115f1b9bd50ba4c49ba8f40f43c7dc66fbd96450
        ];
        uint256[2][2] memory b = [
            [0x2aa4ff5eb7fc06306df8353b77173ad3ece671bfa55fd12240c9509bd4ff0d51,
             0x1eca26483822603fdca4056a915cd5349928e16ca457c69f7fdaca274f2a90bd],
            [0x293f75f888955eeb903b7fa37d5733e8833418a97395e0facbe945ced7463a7d,
             0x015940e84059ee5661f3fc38e6e2d59c161a070297dba17c5dd088a1fe8dc482]
        ];
        uint256[2] memory c = [
            0x18f3a765e7ee768a87c41c1bfab59decb3aedc34fda557174be0634eab7b12eb,
            0x11d9a6e5bdd6837fccc8b0018baf2290990d996c1d4dc60766efeda2569f950d
        ];
        uint256[2] memory public_input = [
            uint256(0x0000000000000000000000000000000000000000000000000000000000000052),
            uint256(0x0000000000000000000000000000000000000000000000000000000000000005)
        ];

        // Check initial counter value
        assertEq(verifier.counter(), 0, "Initial counter should be 0");

        // Expect the transaction to succeed
        verifier.callVerifyProof(a, b, c, public_input);

        // Check if counter was incremented
        assertEq(verifier.counter(), 1, "Counter should be incremented to 1");

        // Expect the transaction to fail with fake proof
        uint256[2] memory fake_a = [
            0x17cf6c553e4c37cebfbc64623e2d08e6ea6ff55913b1231cc0c25fd721abc36f,
            0x24d47f57ac26b35af9787bf1115f1b9bd50ba4c49ba8f40f43c7dc66fbd96450
        ];
        vm.expectRevert();
        verifier.callVerifyProof(fake_a, b, c, public_input);

        // Check the counter value
        assertEq(verifier.counter(), 1, "Counter should remain at 1");
    }
}
