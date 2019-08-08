# frozen_string_literal: true

def pry?
  true # obviously
end

def setup_pry
  return unless pry?

  add_development_gem "gem 'pry-rails'"
  run 'bundle install'
  commit 'Add pry rails.'
end
