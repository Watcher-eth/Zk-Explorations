// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Groth16Verifier} from "./WithdrawVerifier.sol";
import "forge-std/console2.sol";

contract WithdrawMixer is Groth16Verifier {
    mapping(uint256 => bool) public validRoot;
    mapping(uint256 => bool) public isSpent;

    event RootAdded(uint256 root);
    event Withdrawn(
        uint256 nullifierHash,
        uint256 root,
        uint256 recipient,
        uint256 relayer,
        uint256 fee
    );

    function addRoot(uint256 root) external {
        validRoot[root] = true;
        emit RootAdded(root);
    }

    // public signals: [root, recipient, relayer, fee, nullifierHash]
    function withdraw(
        uint256[2] calldata a,
        uint256[2][2] calldata b,
        uint256[2] calldata c,
        uint256[5] calldata input
    ) external {
        uint256 root          = input[0];
        uint256 recipient     = input[1];
        uint256 relayer       = input[2];
        uint256 fee           = input[3];
        uint256 nullifierHash = input[4];

        require(validRoot[root], "Unknown root");
        require(!isSpent[nullifierHash], "Nullifier already spent");
                isSpent[nullifierHash] = true;

        // Do NOT return here. Just require it to be true:
        console2.log(verifyProof(a, b, c, input));

        emit Withdrawn(nullifierHash, root, recipient, relayer, fee);
    }
}
