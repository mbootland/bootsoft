# 1. Base image
FROM ruby:4.0.1-slim

# 2. Install dependencies
RUN apt-get update -qq && \
  apt-get install -y \
  build-essential \
  libsqlite3-dev \
  libyaml-dev \
  curl \
  git && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# 3. Directory setup
WORKDIR /app

# 4. Dependency caching
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test' && \
  bundle install

# 5. Copy code
COPY . .

# 6. Precompile assets (Added dummy secret)
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rake assets:precompile

# 7. Create user and ensure directories exist with correct permissions
RUN useradd -m -u 1000 appuser && \
  mkdir -p /app/db /app/log /app/storage /app/tmp && \
  chown -R appuser:appuser /app/db /app/log /app/storage /app/tmp
USER appuser

# 8. Start with Thruster
# Cloud Run sets $PORT automatically; Thruster uses it.
EXPOSE 8080
CMD ["./bin/thrust", "bundle", "exec", "puma", "-C", "config/puma.rb"]