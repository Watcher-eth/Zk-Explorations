pragma circom 2.1.7;

include "../node_modules/circomlib/circuits/poseidon.circom";
include "../node_modules/circomlib/circuits/bitify.circom";

template HashPreimage16() {
    signal input x;       // private 
    signal input H;       // public

    component n2b = Num2Bits(16);
    n2b.in <== x;         // assigns and constraint: enforces 0 <= x < 2^16

    component pose = Poseidon(1); // CREATES POSEIDON SUBCIRCUIT WITH INPUT ARRAY LENG 1
    pose.inputs[0] <== x; // ASSIGNS AND CONSTRAINS: pose.inputs[0] = x && pose.inputs[0] === x

    pose.out === H;  // CONSTRAINT: pose.out === H
}

component main { public [H] } = HashPreimage16(); // PUBLIC INPUTS: H PRIVATE INPUTS: x <== 2^16
