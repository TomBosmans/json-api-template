# frozen_string_literal: true

require_relative 'commits'

run 'bundle install'
commit 'this is not the commit you are looking for.'

setup_rspec
setup_rubocop
