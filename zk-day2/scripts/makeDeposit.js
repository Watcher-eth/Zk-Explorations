// scripts/make_input.js
const { buildPoseidon } = require("circomlibjs");

async function main() {
  // Get the Poseidon hash function:
  //    buildPoseidon() returns the fn itself, with F attached.
  const poseidon = await buildPoseidon();

  // Your secret x (a BigInt)
  const secret = 4242n;

  // Your nullifier
  const nullifierSalt = 669n;

  // Compute the field‑element hash (returns a BigInt)
  const commitment = poseidon([secret, nullifierSalt]);
  console.log("Commitment:", poseidon.F.toString(commitment));

  // Serialize the field element to a decimal string
  const commitmentStr = poseidon.F.toString(commitment);
  console.log("CommitmentStr:", commitmentStr);

  // Output JSON for snarkjs
  console.log(JSON.stringify({
    secret: secret.toString(),
    nullifierSalt: nullifierSalt.toString(),
  }, null, 2));
}

main().catch(console.error);
