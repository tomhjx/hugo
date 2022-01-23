FROM golang:1.17.5-bullseye as builder
ENV SITE_DIR="/var/www"
RUN mkdir $HOME/src && \
    cd $HOME && \
    git clone --branch v0.92.0 https://github.com/gohugoio/hugo.git && \
    cd hugo && \
    go install --tags extended && \
    echo $PATH && \
    hugo version && \
    which go hugo && \
    hugo new site $SITE_DIR && \
    git clone https://github.com/google/docsy.git $SITE_DIR/themes/docsy && \
    cd $SITE_DIR/themes/docsy && \
    git submodule update --init --recursive

FROM debian:bullseye-slim
ENV SITE_DIR="/var/www"
WORKDIR $SITE_DIR
COPY --from=builder /go/bin/hugo /usr/local/bin/hugo
COPY --from=builder $SITE_DIR $SITE_DIR