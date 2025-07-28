// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {DepositRegistry} from "../contracts/DepositSys.sol";

contract DepositRegistryTest is Test {
    event Deposited(uint256 commitment);

    DepositRegistry reg;

    uint256[2] proofA = [
        0x0c6f2ee584603fc26423715df64ba04f970f4ccf7b338f6b196683dd20c21c80,
        0x082cdda7095ed4692875bc383f9261ce18b7ba4e662b75ebed35eb78ce277743
    ];
    uint256[2][2] proofB = [
        [
            0x0dd21ee159dbd7f91d8e77ec42850cec4d275bf60516f295c57acbcf4a069b85,
            0x0f6803fe3829c348ea5b48b86baf2f9e1a1c3c6ad317a684c4a4de43894a3094
        ],
        [
            0x2b8cb36780d4c8e55d5a2a494c0f5704ea0055fc3d8dec506aabe777302edd23,
            0x1204d9deab52701693ccb9eb6c5b07bc31816966280114c5ad50cb4cee7d33f4
        ]
    ];
    uint256[2] proofC = [
        0x16fbab970cc52b06a21f5f9a3776ef351c0137788902f75e91043dfa42452187,
        0x1d84d7ca2c153f6983dac1987a16999eb4c99866c72ce0c9c76db8b830be268c
    ];
    uint256[1] pubIn = [
        1836072884256463352055689553780935194447813363323232370615599725435533742854
    ];

    function setUp() public { reg = new DepositRegistry(); }

    function testDeposit() public {
        uint256 k = pubIn[0];

        assertTrue(reg.verifyProof(proofA, proofB, proofC, pubIn));
        assertFalse(reg.committed(k));

        // event has 0 indexed args → check only data; specify emitter
        vm.expectEmit(false, false, false, true, address(reg));
        emit Deposited(k);

        reg.deposit(proofA, proofB, proofC, pubIn);

        assertTrue(reg.committed(k));
    }
}
