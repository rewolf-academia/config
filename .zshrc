export ACADEMIA_SSH_KEY="~/.ssh/github_ed25519"
export ACADEMIA_LDAP_USERNAME=remy
export ACADEMIA_CERTIFICATE="~/academia/academia-root-ca.crt"
export ACADEMIA_SHELL="~/.academia-shell/"

export SSH_AUTH_SOCK="~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

alias reload="source ~/.zshrc"
alias vssh="ssh devdemia.com"
alias landrush="cd ~/academia/academia-app-vagrant/ && aws-vault exec academia -- ./landrush remy"

export PATH="$ACADEMIA_SHELL/bin/:$PATH"
