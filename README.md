# Groth16 Verifier Contract
```bash
# Unit tests
forge test
forge test --match-test testGnark -vvvv

# Deploy and call verify function
# Add your secret in .env
source .env

# XLayer
# simulate on XLayer, legacy mode without EIP-1559
forge script script/GnarkP256Verifier.sol --rpc-url $XLAYER_RPC_URL --legacy 
# Real deployment, with --broadcast
forge script script/GnarkP256Verifier.sol --rpc-url $XLAYER_RPC_URL --legacy --broadcast

# Sepolia
forge script script/GnarkP256Verifier.sol --rpc-url $SEPOLIA_RPC_URL
forge script script/GnarkP256Verifier.sol --rpc-url $SEPOLIA_RPC_URL --broadcast
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
