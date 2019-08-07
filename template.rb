# frozen_string_literal: true

require_relative 'commits'

run 'bundle install'
commit 'This is not the commit you are looking for.'

setup_rspec
setup_factory_bot
setup_redis
setup_rubocop
