FROM node:alpine as builder
WORKDIR /usr/src/audio
COPY . .
RUN npm install
RUN npm run build
RUN rm -rf node-modules

FROM rust:1.69
WORKDIR /usr/src/audio
COPY --from=builder /usr/src/audio /usr/src/audio
RUN cargo install --path .
RUN cargo clean

EXPOSE 8000

CMD ["audio"]