FROM golang:1.18.3-bullseye as builder
ENV SITE_DIR="/var/www"
RUN mkdir $HOME/src && \
    cd $HOME && \
    git clone --branch v0.101.0 https://github.com/gohugoio/hugo.git && \
    cd hugo && \
    go install --tags extended && \
    echo $PATH && \
    hugo version && \
    which go hugo && \
    hugo new site $SITE_DIR && \
    git clone --branch v0.4.0 https://github.com/google/docsy.git $SITE_DIR/themes/docsy && \
    cd $SITE_DIR/themes/docsy && \
    git submodule update --init --recursive

FROM debian:bullseye-slim
ENV SITE_DIR="/var/www"
WORKDIR $SITE_DIR
COPY --from=builder /go/bin/hugo /usr/local/bin/hugo
COPY --from=builder $SITE_DIR $SITE_DIR
RUN apt update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    node -v && \
    npm -v && \
    cd $SITE_DIR && \
    npm install -D autoprefixer postcss-cli postcss@^8.1.0 && \
    npm audit fix
