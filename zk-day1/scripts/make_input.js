// scripts/make_input.js
const { buildPoseidon } = require("circomlibjs");

async function main() {
  // 1) Get the Poseidon hash function:
  //    buildPoseidon() returns the fn itself, with F attached.
  const poseidon = await buildPoseidon();

  // 2) Your secret x (a BigInt)
  const x = 4242n;

  // 3) Compute the field‑element hash (returns a BigInt)
  const Hfield = poseidon([x]);

  // 4) Serialize the field element to a decimal string
  const H = poseidon.F.toString(Hfield);

  // 5) Output JSON for snarkjs
  console.log(JSON.stringify({
    x: x.toString(),
    H
  }, null, 2));
}

main().catch(console.error);
