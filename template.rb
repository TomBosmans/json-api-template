# frozen_string_literal: true

require_relative 'commits'

gitignore '.DS_Store'
insert_into_file 'Gemfile', "\ngroup :test do\nend\n\n", before: 'group :development do'
run 'bundle install'
commit 'This is not the commit you are looking for.'

setup_rspec
setup_factory_bot
setup_shoulda_matchers
setup_redis
setup_simplecov
setup_annotate
setup_erd
setup_rubocop
