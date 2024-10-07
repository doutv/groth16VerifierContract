// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Verifier} from "../src/GnarkSingleP256Verifier.sol";

contract DeployAndVerifyProofScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        Verifier verifier = new Verifier();
        console2.log("Verifier deployed at:", address(verifier));
        verifyProof(address(verifier));

        vm.stopBroadcast();
    }

    function callVerifyProof(address verifierAddr) public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        verifyProof(verifierAddr);
        vm.stopBroadcast();
    }

    function verifyProof(address verifierAddr) internal {
        Verifier verifier = Verifier(verifierAddr);
        uint256[8] memory proof = [
            uint256(
                0x0EB92045FDE9C3170CCA6F6CD06B22C13AC0312C13B78E88D8A7E0BA9D7E6ECA
            ),
            uint256(
                0x1BCC830249611E4AA65E7669C87D79B0042810E20BEB6354D1B4D46E02841D30
            ),
            uint256(
                0x2B6F2EF2017109DF10A255A043E26DBA99592AA165EB3A8EE26FD4758C4437C1
            ),
            uint256(
                0x2FCDDEDB242562B961A05863A07883F4110D4EAB703976220B3DE8BC216A77A1
            ),
            uint256(
                0x2F84E70F9224819E85944256D025FB48B7050183C352B60FB39DD458BA32D432
            ),
            uint256(
                0x20015003DD59E20592E6D93F14C9A7E87BA027F223C0A4BFA5E3D0BABC8F88EA
            ),
            uint256(
                0x284C6493BD9443AFE045A5508B80E47147C82DC2D9FC04D590EB74FE3A5DB5E8
            ),
            uint256(
                0x122221A5041A5497695B594ED0C34706D37FAAC2034B37C6E301212C7B312DC4
            )
        ];
        uint256[2] memory commitments = [
            uint256(
                0x0C832C534D1BD3A5A9559DB1169638788EC892FFC217DF49D3C2FEFBA98E6676
            ),
            uint256(
                0x274A18E703DE630563AADC1B90DF7967EA492857EEF2CED4B91EDAB614CEF9E6
            )
        ];
        uint256[2] memory commitmentsPok = [
            uint256(
                0x1844777ACDCDCD7D9646492F395E7DE7752403A8F017F988DCA9AFF41BEDA22C
            ),
            uint256(
                0x254D96DC20EE821A48C5EA595427D0FA63939780E75AEFD87CF1228C1088B16C
            )
        ];
        uint256[1] memory publicInput = [
            uint256(
                0x00DA5D4804CCA342E3FE52A9D1B4103F5AC52170662AB20FB18BEDF1CAC2C111
            )
        ];

        try
            verifier.callVerifyProof(
                proof,
                commitments,
                commitmentsPok,
                publicInput
            )
        {
            console2.log("Proof verification successful");
        } catch Error(string memory reason) {
            console2.log("Proof verification failed. Reason:", reason);
        } catch (bytes memory lowLevelData) {
            console2.log("Proof verification failed. Low-level error:");
            console2.logBytes(lowLevelData);
        }
    }
}
