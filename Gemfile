source 'https://rubygems.org'

ruby '2.7.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
#
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 5.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# gem 'webpacker'
gem 'webpacker', github: 'rails/webpacker'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'baby_squeel'
gem 'active_decorator'
gem 'active_decorator_with_decorate_associations'
gem 'kaminari'
gem 'ransack'
gem 'dotenv-rails'
gem 'default_value_for'
gem 'active_type'
gem 'active_hash'
gem 'enumerize', github: 'brainspec/enumerize'
gem 'bugsnag'
gem 'ridgepole'
gem 'rack-user_agent'
gem 'newrelic_rpm'
gem 'slim-rails'
gem 'simple_form'
# sidekiq
gem 'sidekiq'
gem 'sidekiq-failures'
gem 'sidekiq-history'
gem 'sidekiq-statistic'
gem 'sidekiq-limit_fetch'
gem 'redis-namespace'
gem 'redis-rails'
gem 'semantic-ui-sass', git: 'https://github.com/doabit/semantic-ui-sass.git'


group :test, :development do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'fakeweb'
  gem 'database_rewinder'
  gem 'delorean'
  gem 'rubocop'
  gem 'brakeman'
  gem 'faker', '~> 1.4.3'
  gem 'capybara', '~> 2.13'
  gem 'poltergeist'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'database_cleaner', '~> 1.3.0'
  gem 'launchy', '~> 2.4.2'
  gem 'selenium-webdriver'
  gem 'rspec_junit_formatter', '0.2.2' #for circleci
  gem 'rspec-json_matcher'
  gem 'rspec-retry'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rails-footnotes'
end

group :development, :staging, :staging_heroku do
  gem 'letter_opener'
  gem 'letter_opener_web'
end


group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate', git: 'git://github.com/ctran/annotate_models.git'
  gem 'view_source_map'
  gem 'rails_layout', github: 'RailsApps/rails_layout'
  gem 'seed_dump'
  gem 'pry'
  gem 'pry-rails'
end

group :test do
  gem 'webmock'
  gem 'vcr'
  gem 'timecop'
end
