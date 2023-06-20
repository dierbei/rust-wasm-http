# syntax=docker/dockerfile:1

FROM --platform=$BUILDPLATFORM rust:1.69 AS buildbase
WORKDIR /src
RUN <<EOT bash
    set -ex
    apt-get update
    apt-get install -y \
        git \
        clang
    rustup target add wasm32-wasi
EOT
# This line installs WasmEdge including the AOT compiler
RUN curl -sSf https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/install.sh | bash

FROM buildbase AS build
COPY Cargo.toml .
COPY src ./src 
# Build the Wasm binary
RUN cargo build --target wasm32-wasi --release
# This line builds the AOT Wasm binary
RUN /root/.wasmedge/bin/wasmedgec target/wasm32-wasi/release/rust-origin-http.wasm rust-origin-http.wasm

FROM scratch
ENTRYPOINT [ "rust-origin-http.wasm" ]
COPY --link --from=build /src/rust-origin-http.wasm /rust-origin-http.wasm