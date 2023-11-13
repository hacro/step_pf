FROM ruby:3.1.2

WORKDIR /app

RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
RUN set -x && apt-get update -y -qq && apt-get install -yq nodejs yarn sudo

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN wget https://wals.s3.ap-northeast-1.amazonaws.com/curriculum/rails/environment.sh
RUN sh environment.sh
RUN gem install bundler && bundle install
COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]