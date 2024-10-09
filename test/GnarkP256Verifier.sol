// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Verifier} from "../src/GnarkSingleP256Verifier.sol";

contract GnarkP256Verifier is Test {
    Verifier public verifier;
    bytes32 constant MASK = 0x00ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    
    function setUp() public {
        verifier = new Verifier();
    }

    function testGnark() public {
        uint256[8] memory proof = [
            uint256(0x0EB92045FDE9C3170CCA6F6CD06B22C13AC0312C13B78E88D8A7E0BA9D7E6ECA),
            uint256(0x1BCC830249611E4AA65E7669C87D79B0042810E20BEB6354D1B4D46E02841D30),
            uint256(0x2B6F2EF2017109DF10A255A043E26DBA99592AA165EB3A8EE26FD4758C4437C1),
            uint256(0x2FCDDEDB242562B961A05863A07883F4110D4EAB703976220B3DE8BC216A77A1),
            uint256(0x2F84E70F9224819E85944256D025FB48B7050183C352B60FB39DD458BA32D432),
            uint256(0x20015003DD59E20592E6D93F14C9A7E87BA027F223C0A4BFA5E3D0BABC8F88EA),
            uint256(0x284C6493BD9443AFE045A5508B80E47147C82DC2D9FC04D590EB74FE3A5DB5E8),
            uint256(0x122221A5041A5497695B594ED0C34706D37FAAC2034B37C6E301212C7B312DC4)
        ];
        uint256[2] memory commitments = [
            uint256(0x0C832C534D1BD3A5A9559DB1169638788EC892FFC217DF49D3C2FEFBA98E6676),
            uint256(0x274A18E703DE630563AADC1B90DF7967EA492857EEF2CED4B91EDAB614CEF9E6)
        ];
        uint256[2] memory commitmentPok = [
            uint256(0x1844777ACDCDCD7D9646492F395E7DE7752403A8F017F988DCA9AFF41BEDA22C),
            uint256(0x254D96DC20EE821A48C5EA595427D0FA63939780E75AEFD87CF1228C1088B16C)
        ];
        uint256[1] memory publicInput = [uint256(0x00DA5D4804CCA342E3FE52A9D1B4103F5AC52170662AB20FB18BEDF1CAC2C111)];

        // Define the public key and transaction hash
        uint256 pubkeyX = 0xb2912598c8a71a21d687417b38f8e17b1beff0d9f356703c660a270b8097cc87;
        uint256 pubkeyY = 0x87a23d09b5e2943edbcfc997b75cb111195dfafb93b7884ca2bd6926423f6ad9;
        uint256 txHash = 0xe5890590b13688c8da33a748f1c0683426ce927cc71c88e5002bba677ef03af4;

        // Calculate hash
        bytes32 calculatedHash = keccak256(abi.encodePacked(pubkeyX, pubkeyY, txHash));
        // Set calculatedHash[0] = 0 using bitwise AND
        calculatedHash = calculatedHash & bytes32(MASK);
        // Assert that publicInput matches the calculated hash
        assert(publicInput[0] == uint256(calculatedHash));

        // Expect the transaction to succeed
        verifier.verifyProof(proof, commitments, commitmentPok, [uint256(calculatedHash)]);

        // Expect the transaction to fail with fake proof
        // uint256[2] memory fake_a = [
        //     0x17cf6c553e4c37cebfbc64623e2d08e6ea6ff55913b1231cc0c25fd721abc36f,
        //     0x24d47f57ac26b35af9787bf1115f1b9bd50ba4c49ba8f40f43c7dc66fbd96450
        // ];
        // vm.expectRevert();
        // verifier.callVerifyProof(fake_a, b, c, public_input);
    }
}