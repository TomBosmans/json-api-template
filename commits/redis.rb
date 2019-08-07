# frozen_string_literal: true

REDIS_CONFIG = <<-CODE
# frozen_string_literal: true

Redis.current = Redis.new(host: ENV['REDIS_HOST'] || 'localhost')
CODE

REDIS_SUPPORT = <<-CODE
# frozen_string_literal: true

module RedisHelper
  extend ActiveSupport::Concern

  included do
    after { Redis.current.flushdb }
  end
end

RSpec.configure do |config|
  config.include RedisHelper
  config.before(:suite) { Redis.current.select(1) } # select db 1
end
CODE

def redis?
  true
end

def setup_redis
  return unless redis?

  file 'config/initializers/redis.rb', REDIS_CONFIG
  file 'spec/support/redis.rb', REDIS_SUPPORT

  uncomment_lines 'Gemfile', /redis/
  run 'bundle install'
end
