FROM alpine:3.3
MAINTAINER Denis Chekirda <dchekirda@gmail.com>

RUN apk update && apk upgrade && \
  apk add ruby-json ruby-irb ruby-nokogiri ruby-thread_safe ruby-tzinfo bash && \
  apk add build-base ruby-dev && \
  apk add --update ruby ruby-io-console ca-certificates && update-ca-certificates && rm -rf /var/cache/apk/* && \
  gem install fluentd --no-ri --no-doc && \
  gem install fluent-plugin-elasticsearch --no-document &&\
  gem install fluent-plugin-forest --no-document &&\
  apk del build-base ruby-dev && \
  rm -rf /root/.gem

COPY config/fluentd.conf /etc/fluent/fluent.conf
EXPOSE 24224

CMD ["/usr/bin/fluentd"]
