# Groth16 Verifier Contract
```bash
# Unit tests
forge test --via-ir

# Deploy and call verify function
# Add your secret in .env
source .env

# 1 signature per proof
# XLayer
# simulate on XLayer, legacy mode without EIP-1559
forge script script/GnarkP256Verifier.sol --rpc-url $XLAYER_RPC_URL --legacy 
# Real deployment, with --broadcast
forge script script/GnarkP256Verifier.sol --rpc-url $XLAYER_RPC_URL --legacy --broadcast

# Sepolia
forge script script/GnarkP256Verifier.sol --rpc-url $SEPOLIA_RPC_URL
forge script script/GnarkP256Verifier.sol --rpc-url $SEPOLIA_RPC_URL --broadcast
# If you want to verify the contract on etherscan
# Example: https://sepolia.etherscan.io/address/0x1566a49f49130C4a809909951D230A22B6FeCaFf
forge script script/GnarkP256Verifier.sol --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
# call function of a deployed contract
export sepolia_contract=<sepolia_contract_address>
forge script script/GnarkP256Verifier.sol --rpc-url $SEPOLIA_RPC_URL --sig callVerifyProof $sepolia_contract

# 10 signatures per proof
# Sepolia
forge script script/p256-10Verifier.sol --rpc-url $SEPOLIA_RPC_URL --via-ir --broadcast --verify
```

## Foundry Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
