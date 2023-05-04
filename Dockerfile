FROM node:alpine as builder
WORKDIR /usr/src/audio
COPY ./package.json ./package-lock.json .
RUN npm install
COPY . .
RUN npm run build

FROM rust:1.67
WORKDIR /usr/src/audio
COPY --from=builder /usr/src/audio /usr/src/audio
RUN cargo install --path .

EXPOSE 8000
ENV ROCKET_ENV=staging
CMD ["audio"]