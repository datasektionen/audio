FROM node:alpine as builder
WORKDIR /usr/src/audio
COPY . .
RUN npm install
RUN npm run build
RUN rm -rf node-modules

FROM rust:1.67
WORKDIR /usr/src/audio
COPY --from=builder /usr/src/audio /usr/src/audio
RUN cargo install --path .

EXPOSE 8000
ENV ROCKET_ENV=staging
CMD ["audio"]