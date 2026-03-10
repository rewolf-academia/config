# Useful aliases for development
# With help from Garrett Hopp & the Academia wiki

# General
alias acd='cd ~/code/academia-app/'
alias reload='source ~/.bashrc'

# For running the Rails app
alias server='RUBY_DEBUG_OPEN=true ./dev -w hmr ssr renderer'
alias pserver='REAL_S3=true REAL_COSMIC=true TEST_PUBLISHING=true server' # run server w/ publishing-specific flags
alias dbserver='REAL_S3=true REAL_COSMIC=true PRODUCTION_PHOTOS=1 RUBY_DEBUG_OPEN=true ./dev -d -w hmr ssr renderer' # run server using dblab clone of prod data
alias webpack='./dev -s -i hmr ssr renderer'
alias sidekiq='RUBY_DEBUG_OPEN=true ./dev -w hmr ssr renderer puma' # runs background jobs
alias dbsidekiq='RUBY_DEBUG_OPEN=true ./dev -d -w hmr ssr renderer puma'						
alias emails='mailcatcher --ip 0.0.0.0 --foreground' # captures emails
alias console='rails c'
alias dbconsole='RUBY_DEBUG_OPEN=true DBLAB=1 console'
alias rs='RUBY_DEBUG_OPEN=true bundle exec rspec' # runs the test suite
alias rails='bundle exec rails'
alias dbinit='script/dblab -a'		# create a clone of the prod db

# Database/package/routing updates--run if changes are made to master (Gemfile.lock, db/migrations, config/routes.rb, etc)
alias tdb='RAILS_ENV=test rails db:drop db:create db:schema:load'
alias dbm='DUMP_STRUCTURE=n ANNOTATE=n rails db:migrate'
alias esm='bundle exec rake elasticsearch:migrate'
alias routes='RAILS_ENV=asset_compilation bundle exec rake assets:generate_routes_js'
alias abtest='pnpm generate-ab-tests'
alias upd='bundle install && pnpm install && routes && tdb && dbm && esm && abtest'

# Kill zombie server processes--can be useful if devbox starts to run out of RAM
get_server_pids() {
  ps aux | grep -e '[n]ode' -e '[u]nicorn' -e '[r]ails c' -e '[p]uma' -e '[s]idekiq' | grep -v 'vscode-server' | grep -v 'cursor-server' | awk '{print $2}'
}
alias ks='kill $(get_server_pids)'
alias kf='kill -9 $(get_server_pids)' # if the previous command didn't work
