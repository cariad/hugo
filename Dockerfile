FROM ruby:3

ENV HUGO_VERSION 0.91.2
ENV HUGO_URL     https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz

RUN apt-get update                                  && \
    apt-get upgrade                                 && \
    apt-get install git-lfs                         && \
    git lfs install                                 && \
    rm -rf /var/lib/apt/lists/*                     && \
    gem install html-proofer                        && \
    htmlproofer --version                           && \
    curl "${HUGO_URL}" -L -o /tmp/hugo.tar.gz       && \
    tar xzf /tmp/hugo.tar.gz -C /usr/local/bin hugo && \
    rm /tmp/hugo.tar.gz                             && \
    hugo version
