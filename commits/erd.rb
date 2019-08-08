# frozen_string_literal: true

def erd?
  true
end

def setup_erd
  return unless erd?

  run 'brew install graphviz'
  add_development_gem "gem 'rails-erd'"
  run 'bundle install'
  commit 'Add rails erd.'
end
