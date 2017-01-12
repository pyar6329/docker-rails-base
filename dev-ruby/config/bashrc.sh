export CPU_CORES="$(cat /proc/cpuinfo | grep "cpu cores" | wc -l)"
alias be="bundle exec"
alias bi="bundle install --jobs=${CPU_CORES}"
alias bu="bundle update"
alias bers="bundle exec rails s -b 0.0.0.0"
alias besrs="bundle exec spring rails s -b 0.0.0.0"
alias ras="rails s -b 0.0.0.0"
alias rs="spring rspec"
alias rk="spring rake"

alias ls="ls -AFh --color=auto"
alias mk="mkdir -p"

