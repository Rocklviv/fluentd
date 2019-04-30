FROM alpine:3.9
LABEL maintainer="Denis Chekirda <dchekirda@gmail.com>"
LABEL fluent_version="1.4.2"

ENV FLUENTD_VERSION=1.4.2

RUN apk update && apk upgrade && \
  apk add ruby-json ruby-irb ruby-nokogiri bash && \
  apk add build-base ruby-dev && \
  apk add --update ruby ruby-io-console ca-certificates && update-ca-certificates && rm -rf /var/cache/apk/* && \
  gem install fluentd --no-ri --no-doc -v ${FLUENTD_VERSION} && \
  gem install fluent-plugin-elasticsearch --no-document &&\
  gem install fluent-plugin-forest --no-document &&\
  gem install etc webrick --no-document --no-ri &&\
  apk del build-base ruby-dev && \
  rm -rf /root/.gem

COPY config/fluentd.conf /etc/fluent/fluent.conf
EXPOSE 24224

CMD ["/usr/bin/fluentd"]
