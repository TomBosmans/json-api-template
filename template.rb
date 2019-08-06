# frozen_string_literal: true

require_relative 'commits'

run 'git add .'
run 'git commit -m "this is not the commit you are looking for."'

setup_rubocop if yes?('do you want rubocop?')
