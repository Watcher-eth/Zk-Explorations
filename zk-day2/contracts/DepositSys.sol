// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Groth16Verifier} from "./DepositVerifier.sol";

contract DepositRegistry is Groth16Verifier {
    mapping(uint256 => bool) public committed;
    event Deposited(uint256 commitment);

    function deposit(
        uint256[2] calldata a,
        uint256[2][2] calldata b,
        uint256[2] calldata c,
        uint256[1] calldata publicInputs
    ) external {
        bool ok = verifyProof(a, b, c, publicInputs);
        if (!ok) {
            revert("Invalid SNARK proof");
        }

        uint256 cm = publicInputs[0];
        if (committed[cm]) {
            revert("Commitment already registered");
        }
        committed[cm] = true;

        emit Deposited(cm);
    }
}
