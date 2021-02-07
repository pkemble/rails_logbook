source 'https://rubygems.org' 

#gem 'activerecord-session_store'
gem 'active_model_serializers'
gem 'httparty'
gem 'bcrypt'
gem 'will_paginate-bootstrap4'
gem 'geokit-rails'
#gem 'ruby-sun-times', require: 'sun_times'
gem 'rails-controller-testing'
gem 'minitest'
gem 'json', '>= 2.5.1'

# rails update
gem 'rexml'
gem 'puma', '~> 5.0'
gem "activerecord-session_store", github: "rails/activerecord-session_store", branch: "master"



# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# Use sqlite3 as the database for Active Record
#gem 'pg'
gem 'mysql2'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

group :production do
	gem 'passenger'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  #gem 'byebug', '~> 8.2'
  gem 'pry-rails'
  gem 'pry-byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
	gem 'rvm-capistrano'
  gem 'capistrano-passenger'
  gem 'listen'
end


gem "webpacker", "~> 5.2"
