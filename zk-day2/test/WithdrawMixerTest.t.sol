// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import {WithdrawMixerV2} from "../contracts/WithdrawPrivateV2.sol";

contract WithdrawMixerTest is Test {
    WithdrawMixerV2 mixer;

    // === paste your calldata ===
    uint256[2] a = [
        0x1ca85e07e6e815051a709f35cfd19cb31f5cf0185553e8eca9003163037a0791,
        0x1044ce6ca048cbb69c7ba35320cea819540ae6ff43a5990b9f0b48b967d5fa82
    ];

    uint256[2][2] b = [
        [
            0x2a996d49735b1325f36e1a406ec0d9e9ce06bbf22ca058b5aba1cae62cd75938,
            0x218119d210afb66d664de4d13faa96c27fb23bfde4d990e9fb7ea5e6725b44ad
        ],
        [
            0x1d400042deb11af777db5a4f83cc4de582dde43fb2ceb670438bd94222a70832,
            0x1ab3c036ae7b89694488fe1d896866c93290416ab48ff940cce305037a5d5345
        ]
    ];

    uint256[2] c = [
        0x113977a98b91347cb9e2c09265466dcf195a430b190513b335abf540fe8eabe3,
        0x191aa43ac9fbfcd8dc05cb28c91a05cc63cbf0adad4bcf4076bca7b40dbc8648
    ];

    // public signals: [root, recipient, relayer, fee, nullifierHash]
    uint256[5] input = [
        0x15bf57d2ed3232f02e1b82eaed4ee0073e165624af71e1fba1747123dce909ed, // root
        0x7b,    // recipient (= 123)
        0x1c8,   // relayer   (= 456)
        0x0,     // fee       (= 0)
        0x0e65ca02b7fc2a9027264808b674349a1acfe175e4a4d89c73c901bc8153512b // nullifierHash
    ];
    // ===========================

    function setUp() public {
        mixer = new WithdrawMixerV2();
        // whitelist the Merkle root we proved against
        mixer.addRoot(input[0]);
    }

    function testWithdraw() public {
    // print the key in the test
    console2.log("test sees key:");
    console2.logUint(input[4]);

    // sanity: proof verifies
    assertTrue(mixer.verifyProof(a, b, c, input));

    // before
    assertFalse(mixer.isSpent(input[4]));

    // call
    mixer.withdraw(a, b, c, input);

    // after
    bool spent = mixer.isSpent(input[4]);
    console2.log("getter after:", spent);
    // assertTrue(spent);
}}
