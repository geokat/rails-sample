# Base image
FROM rails:latest

ENV HOME /home/rails/webapp

WORKDIR $HOME

# Install gems
ADD Gemfile* $HOME/
RUN bundle install

# Add the app code
ADD . $HOME

# Create and seed the database
RUN bundle exec rake db:setup

# Run the tests
RUN bundle exec rake test --verbose

# Default command
CMD ["bundle", "exec", "rails", "server", "--binding", "0.0.0.0"]
