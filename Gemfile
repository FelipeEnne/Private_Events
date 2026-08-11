source 'https://rubygems.org'

ruby '~> 3.4.4'

gem 'rails', '~> 7.2.3', '>= 7.2.3.1'
gem 'sprockets-rails'
gem 'puma', '~> 8.0', '>= 8.0.2'
gem 'jsbundling-rails'
gem 'cssbundling-rails'
gem 'turbo-rails'
gem 'jbuilder'
gem 'bcrypt', '~> 3.1.7'
gem 'font-awesome-rails'
gem 'bootsnap', require: false

group :development, :test do
  gem 'sqlite3', '~> 2.1'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner-active_record'
  gem 'rspec-rails'
  gem 'faker'
end

group :production do
  gem 'pg'
end

group :development do
  gem 'web-console'
  gem 'bundler-audit', require: false
  gem 'brakeman', require: false
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
