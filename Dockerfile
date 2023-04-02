FROM rust:1.64

WORKDIR /usr/src/audio
COPY . .

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
RUN nvm install 16
RUN apt-get install npm
RUN npm install
RUN npm run build
RUN cargo install sqlx-cli
RUN cargo sqlx prepare
RUN cargo install --path .
RUN cargo clean

EXPOSE 8000

CMD ["audio"]