FROM golang:1.17.5-bullseye as builder
RUN mkdir $HOME/src && \
    cd $HOME && \
    git clone --branch v0.92.0 https://github.com/gohugoio/hugo.git && \
    cd hugo && \
    go install --tags extended && \
    echo $PATH && \
    hugo version && \
    which go hugo && \
    git clone --branch v0.1.0 https://github.com/google/docsy.git /var/hugo/themes/docsy

FROM debian:bullseye-slim
ENV SITE_DIR="/var/www"
WORKDIR $SITE_DIR
COPY --from=builder /go/bin/hugo /usr/local/bin/hugo
RUN hugo new site $SITE_DIR
COPY --from=builder /var/hugo/themes/docsy $SITE_DIR/themes/docsy