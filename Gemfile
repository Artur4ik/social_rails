# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.1'

gem 'bcrypt'
gem 'image_processing'
gem 'jsonapi-serializer'
gem 'jwt'
gem 'pg'
gem 'puma'
gem 'rack-cors'
gem 'rails'
gem 'sidekiq'
gem 'sprockets-rails'
gem 'pry'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec', require: false
end
