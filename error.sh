bundle exec pumactl -S pids/puma.state stop
bundle exec puma -C config/puma.rb
echo 'Executing curl http://127.0.0.1:9292/hello/hello.json in background...'
curl http://127.0.0.1:9292/hello/hello.json &
bundle exec pumactl -S pids/puma.state phased-restart
tail -f log/puma.log
