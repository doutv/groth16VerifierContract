// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Verifier} from "../src/p256-10Verifier.sol";

contract GnarkP256Verifier is Test {
    Verifier public verifier;
    
    function setUp() public {
        verifier = new Verifier();
    }

    function test10Sig() public {
        uint256[8] memory proof = [
            uint256(0x068466E96FE3E43A47A45A219D48EBFFC731102FBF921BB681D929F8CCD7DCCD),
            uint256(0x18CA295C5AA34118E0D51A10514B1FEBDDD32C5655296B434AA8731A324081EA),
            uint256(0x124C3E2CBC52722EE1827E22B984BEC788D57BED83D02FB45E88A5F8DF402FC9),
            uint256(0x224878AB963945288E9EC5305622E6E9E4DDA3B8B859D0630B6095D6D67755DA),
            uint256(0x1AC0CC9A2C98ECB5DEDE94825D0FF08B8767E9B5FE13C843D16F423A18586484),
            uint256(0x14FF00434FB50F3716B5F2011C341175EEF7C0E8E478E9FAC850D10E63E97DB9),
            uint256(0x01F608E7E6620BDED6A2472EC329D0AFFE52ECD5E4AF62299476EEF15DD769B4),
            uint256(0x23E4C88D2AC7F2062AA77082A4BD9967A69590BF61A0AB657EA02EA35A10A97B)
        ];
        uint256[2] memory commitments = [
            uint256(0x032AFC4FA24014E503D42052A52FF814628C7EE24CF555F1C08F09B365F98D42),
            uint256(0x157A2732C40ABA0A752BA9B09C236B146F8166763DC6E596C021EDE0650B034A)
        ];
        uint256[2] memory commitmentPok = [
            uint256(0x2D73A3AE1E7D1365AE44C36204FB9280DEDCC250DB8D4F24858A8969ED542B1D),
            uint256(0x228F0592B8F77F4D8AD72FF574AF1B6E1AFDCAD2324CBBF1280D45A60A22226D)
        ];
        // Define the public key and transaction hash
        uint256[10] memory pubkeyX = [
            0x030fc87703466a9a307c5b7fbbe6985b1e792a30be19a4c8484a0290a72cd374,
            0x3a47fda76dfab30b1080e0a4a6c03c99ad93238845dc5b24c870f86c83c53d14,
            0xea7dc30439b41a09fcce47013c2485f8a2c15ab35c911ac5e8ee6983dd5ec59d,
            0xc903021b240253fa0b3c464f63f0b1e40a1f3371fcce23190c612d4ec7a350d6,
            0x3b3de7215a4eafccf3ea1b57c984b748a8094b501df870ff462a4a33f4dcc14b,
            0x0e25f02af448763e065b1a48e4b03d2808222834dd4edd30a48dabafd61b6bc6,
            0x2e881e17544ec4554455490171cc9a3462d46bf2f751f4d8fd1c2813067d88e5,
            0x1122b27bf689e5552e9e5edc817409fb752fb0496290761ded3acd3077272fb4,
            0xe8767191589bd381f8f767b567b7e565dc7b1f8b7513b5644454fdb5f74aacc0,
            0xb77c6c8fc8d15b8e8af67203f645e806811fc6aa3ca2c40cc9ea4583af09d6ba
        ];
        uint256[10] memory pubkeyY = [
            0x64fb4f3f905cba8eb0aaff5ed5ba5e3d7e44d8d6beaefb471882b85e7959521c,
            0x4a2808d2a04201782f0a5612ec82a1a823ec100fe5bea4c9d0da5e61c383aa01,
            0x29381de0a2c9721e368d7a672c8ee575fe665e0812982fc467df930db4f9b024,
            0x5eaa83677b83cbb574418866c38cd801ded44e0eaa67420c3c9e8caf31796ff2,
            0xf8044bd306a66e01e5025825694ba440b72acf56af3572338edb073bc1a32c8d,
            0xb48b965f4b8829a8e68dd2b2640cab9fc1850e14a2ae3a6a094b25e9b8e064af,
            0xafe495bbf9c293748a448da6a6a4ca6b65ead35b1b3a6febad5f793f19d2ecc8,
            0xac7546ecabf713aa638ac3736f47dd2c74aab231b9737d5153391e11bf256e09,
            0xc42bbe2fba54ffbc5f7da1a2804e0b899ece2fc7565814ce62ef27a4a4be41ad,
            0xcb07b7bbef90998a7a6c8f66d2fb1bacc81d5b02c76e090ed557b167c4b6359b
        ];
        uint256[10] memory txHash = [
            0x0d8c4fa9f90482d7684103af38731a4169fee0722c8eead6d2a1d9586a3f212f,
            0xf70ec92daf732c02bfb4becee841c8842df0f84171fa673c8d4bb25aa881b17a,
            0x22947cec0226a5260e347d8e2dfe860265b5c422fbac09f498c7ab0f79bba7b9,
            0x270c1affea2d65ddf8b4d89285cedc63b91525e4a2db4a72d8ff7ee3e373a4bd,
            0xf698692867ddbbdc8d4b1cc74ec9a3006de9afe2c7800e807dd770edf5e38818,
            0xdf5125f9829de6a11fcb351dac59a43716712ae9997869279c95d0a84de88f25,
            0x4d2bf1c1b32ce4fff460b17c3d56f6b5ce0727102ba2615f2dbd8ac183a2aab2,
            0x76a91ef7d809f1b1ea58654ba009b5093d3a7c5b747a18667e4a0282a3327c71,
            0x468fc7e6f2ff60977e454b01648f2ec171a79c1e95ee935fa09365d23696c59c,
            0x4fe2042af0eadc082b87c5cc7e9ebb6cfe16d346f2b08aee7cf7396b1aad8a2a
        ];

        // Expect hash to match
        bytes32 expectedHashOut = 0x00dc7aa3a64588c84ef878fe4baca90684808fa22a125849665b6f597b22f24a;
        bytes32 hashOut = verifier.hash10Signatures(pubkeyX, pubkeyY, txHash);
        assert(hashOut == expectedHashOut);
        // Expect verify to succeed
        verifier.callVerify10Signatures(proof, commitments, commitmentPok, pubkeyX, pubkeyY, txHash);

        // Expect the transaction to fail with fake proof
        uint256[8] memory fakeProof = proof;
        fakeProof[5] = 0x0EB92045FDE9C3170CCA6F6CD06B22C13AC0312C13B78E88D8A7E0BA9D7E6ECA;
        vm.expectRevert();
        verifier.callVerify10Signatures(fakeProof, commitments, commitmentPok, pubkeyX, pubkeyY, txHash);

        // Replace pubkeyX, pubkeyY, txHash with fake values
        uint256[10] memory fakePubkeyX = pubkeyX;
        fakePubkeyX[0] = 0x754d505f6a340d70f323b02554b897702771f237b8dbd5cc1e5084f841e1a97e;
        uint256[10] memory fakePubkeyY = pubkeyY;
        fakePubkeyY[0] = 0x6c8701fdabf35f1365f04d709a9831afb71239c10631b4905c5e8dfd49993075;
        uint256[10] memory fakeTxHash = txHash;
        txHash[0] = 0x7e706b39a6801e115d58a3bd4d82fde24615b92b3283aab5081a72c5ad62acf7;
        vm.expectRevert();
        verifier.callVerify10Signatures(proof, commitments, commitmentPok, fakePubkeyX, fakePubkeyY, fakeTxHash);
    }
}