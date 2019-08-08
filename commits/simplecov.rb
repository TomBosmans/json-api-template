# frozen_string_literal: true

SIMPLECOV = <<-CODE

# needs to be on top to make sure all files are correctly covered.
require 'simplecov'
SimpleCov.start 'rails' do
  minimum_coverage 100
  add_filter 'vendor' # ignore vendor folder
end

CODE

def simplecov?
  true
end

def setup_simplecov
  add_test_gem "gem 'simplecov', require: false"
  run 'bundle install'
  gitignore 'coverage'
  prepend_to_file 'spec/spec_helper.rb', SIMPLECOV
  commit 'Add simplecov'
end
