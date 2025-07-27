// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/HashPreimageDemo.sol";

contract HashPreimageTest is Test {
    HashPreimageDemo demo;

    function setUp() public {
        demo = new HashPreimageDemo();
    }

    function testVerify() public view {
        // The Groth16 proof (a, b, c) and public input (H) from build/calldata.txt
        uint256[2] memory a = [
            0x10599c1c4981b32afd3da71d7fba9055450205d82c9da0fc6e2bee37a3c19dc8,
            0x24ddd7bf15f2ca8981d8449b11d673ed78c44bec99424e59b58d84a74c201932
        ];

        uint256[2][2] memory b = [
            [
                0x0623b128115dc791dec4513ac1e3e5d2d43dfc4b2a3181bedcc80626ce6585f4,
                0x20e86b953a958367125ebb29f53b4c4bba9a994678d31bba682b65e0229a5f61
            ],
            [
                0x04aed12c77a72569aa2fbfcbc53059a17417a2df936b7fa40568ec8c4f934485,
                0x2ab804c620fa54b22df0b29b6dc9bd5ce336eb27e1a608b67445271b18594da1
            ]
        ];

        uint256[2] memory c = [
            0x2118c68b43c67e4680ae7870ed949d25854b2c286ebdec3cb581bf4897ad9404,
            0x0e60ee489f3ff1a217f27bf4c99a3cce6757631a5be345dd82908db1fd8ae7b3
        ];

        uint256[1] memory input = [
            0x142a99f9ccd79627d29776d3d9f7a641bfbce304a011b0a78ee73d74d0846d4b
        ];

        bool ok = demo.verifyPreimage(a, b, c, input);
        assertTrue(ok);
    }
}
