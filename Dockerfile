FROM rust:1.64

WORKDIR /usr/src/audio
COPY . .

RUN wget https://nodejs.org/dist/v18.15.0/node-v18.15.0-linux-x64.tar.xz
RUN tar xvf node-v18.15.0-linux-x64.tar.xz
RUN mv node-v18.15.0-linux-x64/bin/{node,npm} /bin
RUN npm install
RUN npm run build
RUN cargo install sqlx-cli
RUN cargo sqlx prepare
RUN cargo install --path .
RUN cargo clean

EXPOSE 8000

CMD ["audio"]