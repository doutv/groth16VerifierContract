// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Verifier} from "../src/GnarkSingleP256Verifier.sol";

contract GnarkP256Verifier is Test {
    Verifier public verifier;

    function setUp() public {
        verifier = new Verifier();
    }

    function test_verify() public {
        uint256[8] memory proof = [
            0x163CC1F0805D9226EBC76D38F4DBEFB4AFB03B3D2B022F5064BD380DC239D0BC,
            0x201CC888F6EE7296E46F9419DBBC715441AF5AB20C432BFC0A25D10A41A7D80F,
            0x0824AE6CEDE313A218DF767FAD9DF03EACFA2E1978E7E0BDBFC664F05A711B8E,
            0x1A44C3989FF2CB0C351B155154CCDD88D0F9FC31C1A4965CE80F5B9EED5204A8,
            0x0E526C0922692DD93977C416DFA15116C48A6DF484DBB99E4AD822F4202651BD,
            0x173930E6307287230468428E6B0C022D074B825012126FFCA995763B83ABC860,
            0x15AEC3F7B18904D1049E5FCFDDAA248B672072C8CFD9420856D781E32D4FDA9A,
            0x267870A34B8B53FAAA842632DFEB74AEB21BAE6DC21CCCBE76DDDC807F8C1BD5
        ];
        uint256[2] memory commitments = [
            0x0AE3D6E7E8B6751FBDBB5CC7B6DCB55C95122B64158D9E56B7320E682BD3A204,
            0x075A2F01E66238DDD5612F11B235C2B75B126E82F8790F3CCF9629A2FC2C1FE6
        ];
        uint256[2] memory commitmentsPok = [
            0x0FDA980DD210BA3A97700EC4F62622FBB2CBD55F548300220DF974C10216E821,
            0x0692CDC744AAB533231EC3990F51A2F893C78B08542A48223537D30D956B2C00
        ];
        // calculate public input = Hash(pkX, pkY, txHash)
        uint256[1] memory input = [uint256(0x00000000000000000000000000000000000000000000000000000000000000FB)];
        // Expect the transaction to succeed
        verifier.verifyProof(proof, commitments, commitmentsPok, input);

        // Expect the transaction to fail with fake proof
        // uint256[2] memory fake_a = [
        //     0x17cf6c553e4c37cebfbc64623e2d08e6ea6ff55913b1231cc0c25fd721abc36f,
        //     0x24d47f57ac26b35af9787bf1115f1b9bd50ba4c49ba8f40f43c7dc66fbd96450
        // ];
        // vm.expectRevert();
        // verifier.callVerifyProof(fake_a, b, c, public_input);
    }
}
