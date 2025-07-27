# zk‑Day1: Hash Preimage Proof

A minimal end‑to‑end zk‑SNARK example demonstrating how to prove knowledge of a 16‑bit preimage `x` such that

> **Poseidon**(`x`) = `H`

without revealing `x`, and verify it both off‑chain and on‑chain.

---

## 🚀 Overview

- **Circuit**: `circuits/hash_preimage.circom`  
  • Range-check `x < 2¹⁶`  
  • Compute `H = Poseidon(x)`  
  • Expose `H` as a public input

- **Setup & Proving**: `snarkjs`  
  • Powers‑of‑Tau ceremony → Groth16 setup → contribute → export `vkey.json`  
  • Generate witness via WASM  
  • Produce and verify a Groth16 proof off‑chain

- **On‑chain Verification**: Solidity + Foundry  
  • Auto‑generated `contracts/Verifier.sol` via `snarkjs zkey export solidityverifier`  
  • Wrapper contract `contracts/HashPreimageDemo.sol`  
  • Foundry test `test/HashPreimageTest.t.sol` to call `verifyProof(...)`

---

## 📦 Project Structure

```text
zk-day1/
├── circuits/
│   └── hash_preimage.circom     # Circom v2 circuit
├── scripts/
│   └── make_input.js            # JS to compute Poseidon(x) → input.json
├── build/
│   ├── hash_preimage.r1cs       # R1CS constraint system
│   ├── hash_preimage.wasm       # WASM witness generator
│   ├── hash_preimage.sym        # Symbol map for debugging
│   ├── pot12_0000.ptau          # PoT phase1 initial
│   ├── pot12_final.ptau         # PoT phase1 final
│   ├── hash_preimage_0000.zkey  # initial Groth16 key
│   ├── hash_preimage_final.zkey # final proving key
│   ├── vkey.json                # verification key (JSON)
│   ├── input.json               # { x, H } for witness
│   ├── witness.wtns             # full witness
│   ├── proof.json               # SNARK proof object
│   └── public.json              # public signals (H)
├── contracts/
│   ├── Verifier.sol             # auto‑generated Groth16 verifier
│   └── HashPreimageDemo.sol     # inherits Verifier, exposes verifyPreimage()
├── test/
│   └── HashPreimageTest.t.sol   # Foundry test calling verifyProof
├── foundry.toml                 # Foundry config
├── package.json                 # npm scripts & dependencies
└── README.md                    # ← you are here
