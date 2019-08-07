# frozen_string_literal: true

def rspec?
  @rspec ||= yes?('setup rspec?') || :nope
  @rspec == true
end

def setup_rspec
  return unless rspec?

  add_development_gem "gem 'rspec-rails'"
  run 'bundle install'
  run 'bundle exec rails generate rspec:install'
  remove_dir 'test'
  commit 'Add and install rspec.'
end
