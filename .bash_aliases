# Useful aliases for development
# With help from Garrett Hopp & the Academia wiki

# General
alias acd='cd ~/code/academia-app/'
alias reload='source ~/.bashrc'

# For running the Rails app
alias server='acd;yarn run rails-hot'
alias pserver='yes3;cosmic;TEST_PUBLISHING=true server;no3;nocosmic' 	# run server w/ publishing-specific flags
alias webpack='acd;NODE_ENV=hot yarn run webpack'
alias sidekiq='acd;SIDEKIQ=y bundle exec sidekiq'			# runs background jobs
alias emails='acd;mailcatcher --ip 0.0.0.0 --foreground'		# captures emails
alias console='acd;bundle exec rails c'
alias rs='bundle exec rspec'						# runs the test suite
# Include any extra bundles for a specific page (ex, fastwp,letter_submission_page)
fastwp() {
 local args=`echo "$*" | tr ' ' ','`
 webpack --include runtime,webpack_libraries_and_infrequently_changed,core_webpack,sentry,$args 
}

# For turning s3/cosmic on/off
alias yes3='export REAL_S3=true S3_ATTACHMENTS=true'
alias no3='export REAL_S3=false S3_ATTACHMENTS=false'
alias cosmic='export REAL_COSMIC=true'
alias nocosmic='export REAL_COSMIC=false'

# Database/package/routing updates--run if changes are made to master (Gemfile.lock, db/migrations, config/routes.rb, etc)
alias tdb='RAILS_ENV=test bundle exec rails db:drop db:create db:schema:load'
alias dbm='DUMP_STRUCTURE=n ANNOTATE=n rails db:migrate'
alias esm='bundle exec rake elasticsearch:migrate'
alias routes='RAILS_ENV=asset_compilation bundle exec rake assets:generate_routes_js'
alias upd='bundle install && yarn install && tdb && dbm && && esm && routes'

# Kill zombie server processes--can be useful if devbox starts to run out of RAM
get_server_pids() {
  ps aux | grep -e '[n]ode' -e '[u]nicorn' -e '[r]ails c' -e '[p]uma' -e '[s]idekiq' | grep -v 'vscode-server' | awk '{print $2}'
}
alias ks='kill $(get_server_pids)'
alias kf='kill -9 $(get_server_pids)' # if the previous command didn't work
