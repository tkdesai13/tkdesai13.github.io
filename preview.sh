#!/usr/bin/env zsh
set -e

cd "$(dirname "$0")"

# Prefer Homebrew Ruby 3.3 on Apple Silicon/Intel Macs
if [ -d "/opt/homebrew/opt/ruby@3.3/bin" ]; then
  export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"
elif [ -d "/usr/local/opt/ruby@3.3/bin" ]; then
  export PATH="/usr/local/opt/ruby@3.3/bin:$PATH"
fi

bundle install
bundle exec jekyll serve --host 127.0.0.1 --port 4000

