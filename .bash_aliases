# Useful aliases for development
# With help from Garrett Hopp & the Academia wiki

# General
alias acd='cd ~/code/academia-app/'
alias reload='source ~/.bashrc'

# For running the Rails app
alias server='acd;yarn run rails-hot'
alias pserver='yes3;cosmic;TEST_PUBLISHING=true server;no3;nocosmic' 	  # run server w/ publishing-specific flags
alias dbserver='dblab;yes3;prodphotos;server;nodblab;no3;noprodphotos'  # run server using dblab clone of prod data
alias webpack='acd;yarn js-hot'
alias sidekiq='acd;SIDEKIQ=y bundle exec sidekiq'			                  # runs background jobs
alias dbsidekiq='dblab;sidekiq;nodblab'						
alias emails='acd;mailcatcher --ip 0.0.0.0 --foreground'		            # captures emails
alias console='acd;bundle exec rails c'
alias dbconsole='dblab;console;nodblab'
alias rs='bundle exec rspec'						                                # runs the test suite
# Include any extra bundles for a specific page (ex: fastwp letter_submission_page)
fastwp() {
 local args=`echo "$*" | tr ' ' ','`
 webpack --include runtime,webpack_libraries_and_infrequently_changed,core_webpack,sentry,$args 
}
alias dbinit='acd;script/dblab --db main'		# create a clone of the prod db

# For turning flags on/off
alias yes3='export REAL_S3=true S3_ATTACHMENTS=true'
alias no3='unset REAL_S3 S3_ATTACHMENTS'
alias cosmic='export REAL_COSMIC=true'
alias nocosmic='unset REAL_COSMIC'
alias dblab='export DBLAB=1'
alias nodblab='unset DBLAB'
alias prodphotos='export PRODUCTION_PHOTOS=1'
alias noprodphotos='unset PRODUCTION_PHOTOS'

# Database/package/routing updates--run if changes are made to master (Gemfile.lock, db/migrations, config/routes.rb, etc)
alias tdb='RAILS_ENV=test bundle exec rails db:drop db:create db:schema:load'
alias dbm='DUMP_STRUCTURE=n ANNOTATE=n rails db:migrate'
alias esm='bundle exec rake elasticsearch:migrate'
alias routes='RAILS_ENV=asset_compilation bundle exec rake assets:generate_routes_js'
alias upd='bundle install && yarn install && routes && tdb && dbm && esm'

# Kill zombie server processes--can be useful if devbox starts to run out of RAM
get_server_pids() {
  ps aux | grep -e '[n]ode' -e '[u]nicorn' -e '[r]ails c' -e '[p]uma' -e '[s]idekiq' | grep -v 'vscode-server' | awk '{print $2}'
}
alias ks='kill $(get_server_pids)'
alias kf='kill -9 $(get_server_pids)' # if the previous command didn't work
