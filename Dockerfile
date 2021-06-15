FROM ruby:2.5.3

WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

COPY ./src /app
RUN bundle install --system

EXPOSE 4567

CMD ["ruby","main.rb","-o", "0.0.0.0"]