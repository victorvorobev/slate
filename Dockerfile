FROM ruby:2.6.5

ENV DOCS_PORT=$DOCS_PORT
RUN apt-get update && apt-get install -y nodejs \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./Gemfile /usr/src/app/
COPY ./Gemfile.lock /usr/src/app/
WORKDIR /usr/src/app

RUN gem install bundler --version '2.0.2'
RUN bundle install

COPY . /usr/src/app
VOLUME /usr/src/app/source

EXPOSE $DOCS_PORT

CMD bundle exec middleman server --watcher-force-polling --port $DOCS_PORT
