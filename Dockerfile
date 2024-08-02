FROM node:20-alpine as frontend
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY public public
COPY src src
COPY postcss.config.js tailwind.config.js ./
RUN npm run build

FROM rust:1.80-slim-bookworm AS backend
WORKDIR /app
COPY Cargo.toml Cargo.lock sqlx-data.json main.rs ./
COPY migrations migrations
RUN cargo install --path .

FROM debian:bookworm-slim
WORKDIR /app

COPY --from=frontend /app/build build
COPY --from=backend /app/target/release/audio audio
COPY songs.json Rocket.toml ./

EXPOSE 8000
ENV ROCKET_ENV=production
CMD ["/app/audio"]
