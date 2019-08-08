# frozen_string_literal: true

def annotate?
  true
end

def setup_annotate
  return unless annotate?

  add_development_gem "gem 'annotate'"
  run 'bundle install'
  run 'bundle exec rails g annotate:install'
  commit 'Setup annotate.'
end
