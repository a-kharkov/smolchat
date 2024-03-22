# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /rails

# Set development environment
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle"

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential curl git libpq-dev libvips pkg-config unzip

ENV BUN_INSTALL=/usr/local/bun
ENV PATH=/usr/local/bun/bin:$PATH
ARG BUN_VERSION=1.0.1
RUN curl -fsSL https://bun.sh/install | bash -s -- "bun-v${BUN_VERSION}"

# Install application gems
COPY ../../Gemfile ../../Gemfile.lock ./
RUN bundle install

# Install node modules
COPY ../../package.json ../../bun.lockb ./
RUN bun install

# Copy application code
COPY ../.. .

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
