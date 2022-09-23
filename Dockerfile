FROM ubuntu:22.04

ENV AWS_URL         https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip

ENV DEBIAN_FRONTEND noninteractive

ENV HUGO_VERSION    0.104.0
ENV HUGO_URL        https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz

ENV S3HS_VERSION    0.3.0
ENV S3HS_URL        https://github.com/cariad/s3headersetter/releases/download/v${S3HS_VERSION}/s3headersetter-linux-amd64.zip

RUN apt-get update                                  && \
    apt-get upgrade --yes                           && \
    apt-get --no-install-recommends --yes install      \
      curl                                             \
      git-lfs                                          \
      unzip                                         && \
    git lfs install                                 && \
    curl "${AWS_URL}" -o /tmp/aws.zip               && \
    unzip /tmp/aws.zip -d /tmp/aws                  && \
    rm /tmp/aws.zip                                 && \
    /tmp/aws/install                                && \
    rm -rf /tmp/aws                                 && \
    aws --version                                   && \
    curl "${HUGO_URL}" -L -o /tmp/hugo.tar.gz       && \
    tar xzf /tmp/hugo.tar.gz -C /usr/local/bin hugo && \
    rm /tmp/hugo.tar.gz                             && \
    hugo version                                    && \
    curl "${S3HS_URL}" -L -o /tmp/s3hs.zip          && \
    unzip /tmp/s3hs.zip -d /usr/local/bin           && \
    rm /tmp/s3hs.zip                                && \
    s3headersetter -help                            && \
    apt-get uninstall unzip                         && \
    rm -rf /var/lib/apt/lists/*
