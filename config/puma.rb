#!/usr/bin/env puma

daemonize
pidfile 'pids/puma.pid'
state_path 'pids/puma.state'
stdout_redirect 'log/puma.log', 'log/puma_error.log', true
threads 0, 16
workers 2
prune_bundler
