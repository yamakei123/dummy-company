FROM ruby:3.1.2-alpine3.15

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    LC_CTYPE="utf-8"

WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN apk update && \
    apk upgrade --no-cache && \
    apk add --update --no-cache && \
    apk add gcompat && \
    apk add --no-cache linux-headers libxml2-dev make gcc libc-dev nodejs yarn tzdata bash mysql-dev && \
    apk add --no-cache build-base curl-dev mysql-client && \
    rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

RUN gem install -q -N bundler -v 2.3.7
RUN bundle install --jobs=4 --retry=9 --without deploy production
ADD . /myapp

EXPOSE 3000
