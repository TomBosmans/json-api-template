# frozen_string_literal: true

TIME_TRAVEL_SUPPORT = <<-CODE
# frozen_string_literal: true

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers
end
CODE

RESPONSE_SUPPORT = <<-CODE
# frozen_string_literal: true

module ResponseHelper
  extend ActiveSupport::Concern

  included do
    def body
      JSON.parse(response.body)
    end

    let(:data) { body['data'] }
    let(:error_detail) { body['detail'] }
    let(:attributes) { body.dig('data', 'attributes') }
  end
end

RSpec.configure do |config|
  config.include ResponseHelper, type: :controller
end
CODE

def rspec?
  true
end

def setup_rspec
  return unless rspec?

  add_test_gem "gem 'rspec-rails'"
  run 'bundle install'
  run 'bundle exec rails generate rspec:install'
  file 'spec/support/response_support.rb', RESPONSE_SUPPORT
  file 'spec/support/time_travel_support.rb', TIME_TRAVEL_SUPPORT
  remove_dir 'test'
  commit 'Add and install rspec.'
end
