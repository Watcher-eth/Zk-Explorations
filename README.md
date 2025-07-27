# Zk-Explorations
# zk‑Explorations

A curated workspace of zero‑knowledge proof experiments and prototypes, from basic hash preimage SNARKs to private order‑matching circuits for a Hyperliquid dark pool. Each day’s folder is a standalone mini‑project with its own README, scripts, and tests—while this top‑level document ties everything together.

---

## 📖 Table of Contents

1. [Overview](#overview)  
2. [Directory Structure](#directory-structure)  
3. [Daily Summaries](#daily-summaries)  
   - [Day 1: Hash Preimage Proof](#day-1-hash-preimage-proof)  
   - [Day 2: Shielded Merkle Pool (Deposit & Withdraw)](#day-2-shielded-merkle-pool-deposit--withdraw)  
   - [Day 3 (Preview): Private Order Placement & Batch Matching](#day-3-preview-private-order-placement--batch-matching)  
4. [Getting Started](#getting-started)  
5. [Prerequisites](#prerequisites)  
6. [Contributing](#contributing)  
7. [License](#license)

---

## 🧩 Overview

This repository houses a sequence of increasingly sophisticated zk‑SNARK projects:

- **Core Write‑ups** of Circom circuits and snarkjs flows.  
- **On‑chain stubs** in Solidity with Foundry tests for end‑to‑end verification.  
- **Infrastructure scripts** for building and linking tools (`install_zk_stack_mac.sh`).  
- **External repos** (cloned for reference/submodules): Circom compiler, Rapidsnark prover, Tornado‑Core circuits.

Each “Day N” folder contains:

- **`circuits/`** – your `.circom` source.  
- **`scripts/`** – JS helpers to build inputs and proofs.  
- **`build/`** – compiled artifacts (.r1cs, .wasm, .zkey, proof.json, etc.).  
- **`contracts/`** – auto‑generated and wrapper Solidity code.  
- **`test/`** – Foundry or Hardhat tests.  
- **`README.md`** – a daily summary and step‑by‑step guide.

---

## 📂 Directory Structure

```text
explorations/
├── circom/                        # Main Circom 2.x compiler source
├── circom-v1/                     # Circom 1.x compiler source (for legacy circuits)
├── install_zk_stack_mac.sh        # Brew + build script for zk toolchain (macOS)
├── rapidsnark/                    # Rapidsnark CPU prover source
├── tornado-core/                  # Tornado‑Cash circuit repo (v1 → v2 patch)
├── zk-day1/                       # Day 1 project: hash preimage proof
│   ├── circuits/
│   ├── scripts/
│   ├── build/
│   ├── contracts/
│   ├── test/
│   └── README.md
└── zk-day2/                       # Day 2 project: shielded Merkle pool
    ├── circuits/
    ├── scripts/
    ├── build/
    ├── contracts/
    ├── test/
    └── README.md
