# frozen_string_literal: true

def commit(message)
  run 'git add .'
  run "git commit -m '#{message}'"
end

def add_development_gem(code)
  insert_into_file "Gemfile", "\n  #{code}", after: 'group :development do'
end

require_relative 'commits/rspec'
require_relative 'commits/rubocop'
