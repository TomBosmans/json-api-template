# frozen_string_literal: true

def commit(message)
  run 'git add .'
  run "git commit -m '#{message}'"
end

def add_gem(code, after: nil)
  insert_into_file 'Gemfile', "\n  #{code}", after: after
end

def add_test_gem(code)
  add_gem code, after: 'group :test do'
end

def add_development_gem(code)
  add_gem code, after: 'group :development do'
end

def add_development_test_gem(code)
  add_gem code, after: 'group :development, :test do'
end

def gitignore(line)
  run "echo '#{line}' >> .gitignore"
end

require_relative 'commits/rspec'
require_relative 'commits/factory_bot'
require_relative 'commits/shoulda_matchers'
require_relative 'commits/redis'
require_relative 'commits/simplecov'
require_relative 'commits/annotate'
require_relative 'commits/erd'
require_relative 'commits/rubocop'
