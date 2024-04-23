FROM rust:1.77.2-bookworm

RUN apt-get update && apt-get install -y libclang-dev

COPY --from=musl-cross-scip-test /work/scip_install /scip_install
WORKDIR /work
COPY . .
ENV SCIPOPTDIR=/scip_install
ENV RUSTFLAGS='-C target-feature=-crt-static'
RUN cargo build --release
RUN cargo run --release --example create
# ENTRYPOINT ["bash"]
