pragma circom 2.1.7;

// field‑native hash
include "../../node_modules/circomlib/circuits/poseidon.circom";

template Withdraw(DEPTH) {
    // private
    signal input secret;
    signal input nullifierSalt;
    signal input pathElements[DEPTH];
    signal input pathIndices[DEPTH];      // each in {0,1}

    // public
    signal input root;
    signal input recipient;
    signal input relayer;
    signal input fee;                     // optional business output; kept public
    signal input nullifierHash;          // Poseidon(nullifierSalt)

    // 1 leaf = Poseidon(secret, nullifierSalt)
    component leafH = Poseidon(2);
    leafH.inputs[0] <== secret;
    leafH.inputs[1] <== nullifierSalt;

    // 2 Recompute path to root using Poseidon(2)
    signal left[DEPTH];
    signal right[DEPTH];
    signal pathHash[DEPTH + 1];
    pathHash[0] <== leafH.out;

    component H[DEPTH];
    
    for (var i = 0; i < DEPTH; i++) {
        // ensure bitness: b ∈ {0,1}
        pathIndices[i] * (pathIndices[i] - 1) === 0;

        // left = (b ? sibling : hash)   // one product
        left[i]  <== pathHash[i]     + pathIndices[i] * (pathElements[i] - pathHash[i]);

        // right = (b ? hash : sibling)  // one product
        right[i] <== pathElements[i] + pathIndices[i] * (pathHash[i] - pathElements[i]);

        H[i] = Poseidon(2);
        H[i].inputs[0] <== left[i];
        H[i].inputs[1] <== right[i];
        pathHash[i + 1] <== H[i].out;
    }

    // 3 Must match provided root
    pathHash[DEPTH] === root;

    // 4 Nullifier hash = Poseidon(nullifierSalt)
    component nh = Poseidon(1);
    nh.inputs[0] <== nullifierSalt;
    nullifierHash === nh.out;
}

component main { public [root, recipient, relayer, fee, nullifierHash] } = Withdraw(20);
