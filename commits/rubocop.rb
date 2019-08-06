# frozen_string_literal: true

RUBOCOP_FILE = <<-CODE
require: rubocop-rspec

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

Metrics/LineLength:
  Max: 120 # aim for 80, but allow some extra length.
  Exclude:
    - 'config/routes.rb'

RSpec/NestedGroups:
  Max: 4
CODE

RUBOCOP_GEMS = <<-CODE

  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
CODE

def autofix_rubocop
  return unless yes?('autofix rubocop warnings?')

  run 'bundle exec rubocop -a'
  run 'git add .'
  run 'git commit -m "rubocop autofix"'
end

def generate_rubocop_todo
  return unless yes?('generate rubocop todo?')

  run 'rubocop --auto-gen-config'
  append_to_file '.rubocop.yml', 'inherit_from: .rubocop_todo.yml'
  run 'git add .'
  run 'git commit -m "generate rubocop_todo"'
end

def setup_rubocop
  insert_into_file "Gemfile", RUBOCOP_GEMS, after: 'group :development do'
  file '.rubocop.yml', RUBOCOP_FILE
  run 'git add .'
  run 'git commit -m "add rubocop"'

  after_bundle do
    autofix_rubocop
    generate_rubocop_todo
  end
end
