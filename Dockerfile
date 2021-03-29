FROM rust:1-slim as builder
WORKDIR /var/local/app
COPY ./Cargo.* ./
RUN mkdir -p ./src && touch ./src/lib.rs
RUN cargo build --release
COPY ./src ./src
RUN cargo build --release

FROM debian:buster-slim
COPY --from=builder /var/local/app/target/release/actix-hello-world /usr/local/bin/actix-hello-world
CMD ["actix-hello-world"]
