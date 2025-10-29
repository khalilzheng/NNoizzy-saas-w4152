source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.7"

gem "rails", "~> 7.1.3"
gem "pg", "~> 1.5"
gem "puma", "~> 6.4"
gem "sassc-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

group :development, :test do
  gem "sqlite3", "~> 1.7"

  gem "rspec-rails", "~> 6.0"
  gem "cucumber-rails", require: false
  gem "database_cleaner-active_record"
  gem "capybara"
  gem "selenium-webdriver", ">= 4.8"
  gem "listen", "~> 3.3"
  gem "debug", platforms: [:mri]
end

group :development do
  gem "web-console"
  
end
group :test do
  gem 'simplecov', require: false
end

 
gem "fiddle"
gem "win32ole"

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
