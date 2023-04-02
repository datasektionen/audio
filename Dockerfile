FROM rust:1.64

WORKDIR /usr/src/audio
COPY . .

RUN wget https://nodejs.org/dist/v18.15.0/node-v18.15.0-linux-x64.tar.xz \
    && mkdir -p /usr/local/lib/nodejs \
    && tar -xJvf node-v18.15.0-linux-x64.tar.xz -C /usr/local/lib/nodejs \
    && ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/node /bin/node \
    && ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/npm /bin/npm \
    && ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/npx /bin/npx
RUN ls /bin
RUN npm install
RUN npm run build
RUN cargo install sqlx-cli
RUN cargo sqlx prepare
RUN cargo install --path .
RUN cargo clean

EXPOSE 8000

CMD ["audio"]