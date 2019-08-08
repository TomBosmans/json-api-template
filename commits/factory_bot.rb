# frozen_string_literal: true

FACTORY_BOT_FILE = <<-CODE
# frozen_string_literal: true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
CODE

def factory_bot?
  true
end

def setup_factory_bot
  return unless factory_bot?

  add_development_test_gem "gem 'factory_bot_rails'"
  add_development_test_gem "gem 'faker'"
  run 'bundle install'

  file 'spec/support/factory_bot_support.rb', FACTORY_BOT_FILE if rspec?
  commit 'Add factory bot with faker'
end
