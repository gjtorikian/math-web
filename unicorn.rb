# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "."

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "./pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/logs/unicorn.log"
# stdout_path "/path/to/logs/unicorn.log"
stderr_path "./logs/unicorn.log"
stdout_path "./logs/unicorn.log"

# Unicorn socket
# listen "/tmp/unicorn.[app name].sock"
listen "/tmp/unicorn.math-web.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30
