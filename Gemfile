source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.7.2"

gem "autoprefixer-rails"
gem "bootsnap", require: false
gem 'bourbon', '>= 6.0.0'
gem 'delayed_job_active_record'
gem 'devise'
gem 'inline_svg'
gem 'high_voltage'
gem 'oj'
gem "pg"
gem "puma"
gem 'rack-mini-profiler', require: false
gem "rack-canonical-host"
gem "rails", "~> 6.0.0"
gem "recipient_interceptor"
gem "sassc-rails"
gem "sprockets", "< 4"
gem 'simple_form'
gem "title"
gem "tzinfo-data", platforms: [:mingw, :x64_mingw, :mswin, :jruby]
gem "webpacker"

group :development do
  gem "web-console"
  gem "listen"
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'standard'
end

group :development, :test do
  gem "awesome_print"
  gem 'bullet'
  gem 'bundler-audit', '>= 0.7.0', require: false
  gem 'factory_bot_rails'
  gem "pry-byebug"
  gem "pry-rails"
  gem 'rspec-rails', '~> 3.6'
  gem "suspenders"
end

group :test do
  gem "formulaic"
  gem "launchy"
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem "timecop"
  gem 'webdrivers'
  gem "webmock"
end


gem 'rack-timeout', group: :production
