FROM ruby
RUN gem install html-proofer && \
    htmlproofer --version
ENV HUGO_VERSION 0.91.2
ENV HUGO_URL     https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
RUN curl "${HUGO_URL}" --location -o /tmp/hugo.tar.gz && \
    tar xzf /tmp/hugo.tar.gz --directory /usr/local/bin hugo && \
    rm /tmp/hugo.tar.gz && \
    hugo version
