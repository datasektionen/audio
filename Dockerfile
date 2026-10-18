FROM node:20-alpine AS frontend
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY public public
COPY src src
COPY postcss.config.js tailwind.config.js ./
RUN npm run build

FROM rust:1.96-slim-bookworm AS backend
WORKDIR /app
COPY Cargo.toml Cargo.lock ./
RUN echo "fn main() {}" > main.rs
# Cache dependencies first
RUN cargo build --locked --release

# COPY preserves the source mtime, which can be older than the stub build above;
# touch it so cargo's mtime-based fingerprint doesn't consider the stub up to date.
COPY main.rs ./
RUN touch main.rs && cargo install --locked --path . --root /usr/local

FROM debian:bookworm-slim
WORKDIR /app

COPY --from=frontend /app/build build
COPY --from=backend /usr/local/bin/audio audio
COPY songs.json Rocket.toml ./

EXPOSE 8000
ENV ROCKET_ENV=production
CMD ["/app/audio"]
