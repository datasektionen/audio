FROM rust:1.64

WORKDIR /usr/src/audio
COPY . .

RUN wget https://nodejs.org/dist/v18.15.0/node-v18.15.0-linux-x64.tar.xz \
    && tar xf node-v18.15.0-linux-x64.tar.xz \
    && mv node-v18.15.0-linux-x64/bin/node /bin/node \
    && mv node-v18.15.0-linux-x64/bin/npm /bin/npm
RUN ls /bin
RUN npm install
RUN npm run build
RUN cargo install sqlx-cli
RUN cargo sqlx prepare
RUN cargo install --path .
RUN cargo clean

EXPOSE 8000

CMD ["audio"]