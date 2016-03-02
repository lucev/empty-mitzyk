source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '~> 4.2'

gem 'haml'
gem 'haml-rails', :group => :development

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
gem 'datetimepicker-rails', github: 'zpaulovics/datetimepicker-rails', branch: 'master', submodules: true
gem 'momentjs-rails', '~> 2.9', github: 'derekprior/momentjs-rails'
gem 'has_scope'

group :production do
  gem 'pg'
end

group :development do
  gem 'sqlite3'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'pry'
end
