FROM ruby:2.6.10

RUN apt-get update -qq && \
    apt-get install -y build-essential \
		       libpq-dev \
		       nodejs \
		       vim

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

#RUN rm -f ./tmp/sockets/.unicorn.sock
ENV RAILS_ENV production
RUN rails assets:precompile

