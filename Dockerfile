FROM ruby:2.4
RUN mkdir /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN useradd -ms /bin/bash admin && chown -R admin:admin /app
USER admin
WORKDIR /app
RUN bundle install
COPY app /app
CMD ["bundle", "exec", "ruby", "app.rb"]
