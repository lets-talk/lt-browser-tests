FROM ruby:2.5.3

RUN mkdir -p /browser-tests

WORKDIR browser-tests

COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock

#RUN bundle install --without test staging
RUN bundle install --jobs=4 --retry=3

COPY . .

RUN chmod +x /browser-tests/run_tests.sh

# CMD RAILS_ENV=qak bundle exec puma -C config/puma.rb
