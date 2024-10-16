FROM rust:1.78 AS builder

WORKDIR /
COPY . 0g-da-encoder
WORKDIR /0g-da-encoder
RUN apt-get update && apt-get install -y protobuf-compiler
RUN cargo build --release

FROM rust:1.78

COPY --from=builder /0g-da-encoder/target/release/server /usr/local/bin/server

VOLUME ["/run"]
WORKDIR /run

CMD ["server"]