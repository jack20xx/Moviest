FROM ruby:2.6.10

ENV DOCKERIZE_VERSION v0.6.1

RUN apt-get update -qq && \
    apt-get install -y build-essential \
		       libpq-dev \
		       nodejs \
		       vim \
			   wget \
			   && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
			   && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
			   && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
			   && apt-get clean \
			   && rm -rf /var/lib/apt/lists/*

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn postgresql-client

RUN mkdir -p /var/www/rails/Moviest

WORKDIR /var/www/rails/Moviest

ADD Gemfile ./Gemfile
ADD Gemfile.lock ./Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . ./

RUN mkdir -p ./tmp/sockets
RUN mkdir -p ./tmp/pids

# RUN rm -f ./tmp/sockets/.unicorn.sock && rm -f ./tmp/pids/unicorn.pid
ENV RAILS_ENV development
RUN rails assets:precompile

