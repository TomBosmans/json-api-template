# frozen_string_literal: true

CORS_FILE = <<-CODE
# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head]
  end
end
CODE

def cors?
  true
end

def setup_cors
  return unless cors?

  uncomment_lines 'Gemfile', /rack-cors/
  run 'bundle install'
  remove_file 'config/initializers/cors.rb'
  file 'config/initializers/cors.rb', CORS_FILE
  commit 'Enable cors.'
end
