pragma circom 2.1.7;

// field‑native hash
include "../../node_modules/circomlib/circuits/poseidon.circom";

template Deposit() {
    // Private secrets
    signal input secret;
    signal input nullifierSalt;

    // Compute the note commitment = Poseidon(secret, salt)
    component hasher = Poseidon(2);
    hasher.inputs[0] <== secret;
    hasher.inputs[1] <== nullifierSalt;

    // Expose it as the single public output
    signal output commitment <== hasher.out;
}

// Mark `commitment` as public
component main = Deposit();
