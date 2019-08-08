# frozen_string_literal: true

def erd?
  true
end

def setup_erd
  return unless erd?

  run 'brew install graphviz' if yes?('brew install graphiz?')
  add_development_gem "gem 'rails-erd'"
  run 'bundle install'
  commit 'Add rails erd.'
end
