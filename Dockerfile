# 1. Base image with Ruby 4.0.1
FROM ruby:4.0.1-slim

# 2. Install dependencies
RUN apt-get update -qq && \
  apt-get install -y build-essential libsqlite3-dev nodejs && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# 3. Set up the app directory
WORKDIR /app

# 4. Copy dependency files first (for better caching)
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

# 5. Copy the app code
COPY . .

# 6. Precompile assets (CRITICAL for production)
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
RUN bundle exec rake assets:precompile

# 7. Create a non-root user
RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

# 8. Start the server (Puma)
EXPOSE 3000
CMD ["./bin/thrust", "bundle", "exec", "puma", "-C", "config/puma.rb"]