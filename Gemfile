source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'redcarpet'
gem 'bulma-rails', '~> 0.5.1'
gem 'font-awesome-rails'
gem 'jquery-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails', '~> 3.6'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'rails-controller-testing'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'ffaker'
  gem 'guard-rspec', require: false
end

gem 'gravatar_image_tag'
gem 'devise'
gem 'simple_form'
gem 'kaminari'
gem 'paypal-sdk-rest'
gem 'rack-cors', :require => 'rack/cors'
gem 'rack-attack'
gem 'rack-tracker'
gem 'cancancan', '~> 2.0'
gem 'rack-mini-profiler'
gem 'figaro'
gem 'mailgun-ruby', '~>1.1.6'
gem 'sucker_punch'
gem 'vuejs-rails'
gem 'knock'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
