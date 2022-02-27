FROM ruby:2.7.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
COPY .. /chainbrain
WORKDIR /chainbrain
RUN ls /chainbrain
EXPOSE 3000
RUN bundle config set force_ruby_platform true
RUN bundle install
CMD ["rails", "server", "-b", "0.0.0.0"]