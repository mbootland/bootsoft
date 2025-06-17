# Dockerfile
FROM ruby:3.2.2

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    npm

# Set working directory
WORKDIR /app

# Install Rails
RUN gem install rails

# Copy Gemfile and Gemfile.lock
COPY Gemfile* ./

# Install gems locally
RUN bundle config set --local path 'vendor/bundle' && \
    bundle install --jobs 4 && \
    bundle list | grep pg

# Copy the rest of the application
COPY . .

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the main process
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]