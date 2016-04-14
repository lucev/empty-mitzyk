source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '~> 4.2'

gem 'slim'

gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier', '>= 1.0.3'

gem 'jquery-rails'
gem 'execjs'
gem 'therubyracer'
gem 'devise'
gem 'capistrano'
gem 'newrelic_rpm'
gem 'thread_safe'
gem 'simple_form'
gem 'font-awesome-rails'
gem 'datetimepicker-rails', git: 'https://github.com/zpaulovics/datetimepicker-rails.git', branch: 'master', submodules: true
gem 'momentjs-rails', '~> 2.9', git: 'https://github.com/derekprior/momentjs-rails.git'
gem 'has_scope'
gem 'rubocop', require: false
gem 'cancancan', '~> 1.10'

group :production do
  gem 'pg'
end

group :development do
  gem 'sqlite3'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: nil
end

group :development, :test do
  gem 'pry'
end
