## 1. Prerequisites
```text
# Install rust
https://www.rust-lang.org/tools/install

# Install wasmedge
https://wasmedge.org/book/en/quick_start/install.html

# Install WebAssembly target for Rust
rustup target add wasm32-wasi
```
## 2. Build
```shell
cargo build --target wasm32-wasi --release
```

## 3. Wasm Compile
```shell
wasmedgec target/wasm32-wasi/release/rust-origin-http.wasm rust-origin-http.wasm
```

## 4. Run
```shell
wasmedge rust-origin-http.wasm
```

## 5.Test
```shell
# get
curl localhost:3030

# post
curl -X POST -H "Content-Type: application/json" -d 'Hello, Kuasar.' http://localhost:3030/echo
```