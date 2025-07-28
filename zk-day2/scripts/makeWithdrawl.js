// scripts/make_withdraw_input.js
const { buildPoseidon } = require("circomlibjs");

async function main() {
  const poseidon = await buildPoseidon();

  // Helper: normalize any field element to BigInt, then to decimal string
  const Fobj = (x) => poseidon.F.toObject(x);          // -> BigInt
  const dec  = (x) => (typeof x === "bigint" ? x : Fobj(x)).toString();

  const DEPTH = 20;

  // Private inputs
  const secret = 4242n;
  const nullifierSalt = 669n;

  // Zero tree siblings (all zeros)
  const Z = [0n];
  for (let i = 0; i < DEPTH; i++) {
    Z.push(Fobj(poseidon([Z[i], Z[i]])));
  }

  // Leaf and root (assume we always go left: pathIndices = 0)
  const leaf = Fobj(poseidon([secret, nullifierSalt]));
  let cur = leaf;
  for (let i = 0; i < DEPTH; i++) {
    cur = Fobj(poseidon([cur, Z[i]]));
  }
  const root = cur;

  // Public metadata + nullifier hash
  const recipient = 123n, relayer = 456n, fee = 0n;
  const nullifierHash = Fobj(poseidon([nullifierSalt]));

  const input = {
    // private
    secret:        secret.toString(),
    nullifierSalt: nullifierSalt.toString(),
    pathElements:  Array.from({ length: DEPTH }, (_, i) => Z[i].toString()),
    pathIndices:   Array(DEPTH).fill(0),

    // public  (order must match your `component main { public [...] }`)
    root:          root.toString(),
    recipient:     recipient.toString(),
    relayer:       relayer.toString(),
    fee:           fee.toString(),
    nullifierHash: nullifierHash.toString()
  };

  console.log(JSON.stringify(input, null, 2));
}

main().catch((e) => { console.error(e); process.exit(1); });
