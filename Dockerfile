FROM ruby:3.2.2

WORKDIR /app
COPY . /app
RUN bundle install

EXPOSE 9292

CMD ["bundle", "exec", "rackup", "config.ru"]
