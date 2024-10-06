# frozen_string_literal: true

# config/puma.rb

# Change the number of threads and workers as needed based on your server's capacity.

# Use more threads for handling incoming requests.
threads_count = ENV.fetch('RAILS_MAX_THREADS', 5)
threads threads_count, threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
port ENV.fetch('PORT', 3000)

# Specifies the `environment` that Puma will run in.
environment ENV.fetch('RAILS_ENV', 'production') # Change to "production" in production.

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch('PIDFILE', 'tmp/pids/server.pid')

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. Adjust as needed.
workers ENV.fetch('WEB_CONCURRENCY', 2)

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
preload_app!

# Additional Puma configuration options can go here as needed.

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart
