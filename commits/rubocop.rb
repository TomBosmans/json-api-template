# frozen_string_literal: true

RUBOCOP_FILE = <<-CODE
require:
  - rubocop-rails

AllCops:
  Exclude:
    - 'db/schema.rb'
    - 'vendor/**/*'

Rails:
  Enabled: true

Rails/HasManyOrHasOneDependent:
  Enabled: false

Documentation:
  Enabled: false

Style/ClassAndModuleChildren:
  Enabled: false

Style/MixinUsage:
  Exclude:
    - 'bin/**/*'

Metrics/BlockLength:
  Exclude:
    - 'spec/**/*.rb'
    - 'lib/tasks/**/*.rake'

Metrics/LineLength:
  Max: 120 # aim for 80, but allow some extra length.
  Exclude:
    - 'config/routes.rb'

RSpec/NestedGroups:
  Max: 4
CODE

def rubocop?
  true
end

def autofix_rubocop
  return unless yes?('autofix rubocop warnings?')

  run 'bundle exec rubocop -a'
  commit 'Run rubocop autofix.'
end

def generate_rubocop_todo
  return unless yes?('generate rubocop todo?')

  run 'rubocop --auto-gen-config'
  append_to_file '.rubocop.yml', 'inherit_from: .rubocop_todo.yml'
  commit 'Generate rubocop todo file.'
end

def setup_rubocop
  return unless rubocop?

  file '.rubocop.yml', RUBOCOP_FILE
  add_development_gem "gem 'rubocop-rails', require: false"

  if rspec?
    add_development_gem "gem 'rubocop-rspec', require: false"
    insert_into_file '.rubocop.yml', "\n- rubocop-rspec\n", before: '- rubocop-rails'
  end

  run 'bundle install'
  commit 'Setup rubocop.'
  autofix_rubocop
  generate_rubocop_todo
end
