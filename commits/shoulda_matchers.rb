# frozen_string_literal: true

SHOULDA_FILE = <<-CODE
# frozen_string_literal: true

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
CODE

def setup_shoulda_matchers
  return unless rspec?

  file 'spec/support/shoulda_matchers_support.rb', SHOULDA_FILE
  add_test_gem "gem 'shoulda-matchers'"
  run 'bundle install'
  commit 'Add shoulda matchers'
end
