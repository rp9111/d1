source 'https://rubygems.org'
ruby '2.4.0'
# the following is for rvm
#ruby=2.3.0@rails500

gem 'rails', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'puma'
gem 'sass-rails', '~> 5.0'

# Assets from Bower
source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap', '4.0.0.alpha.2'
  gem 'rails-assets-parallax.js'
  gem 'rails-assets-jquery.localScroll', '~> 1.4.0'
  gem 'rails-assets-jquery.scrollTo', '~> 2.1.2'
  gem 'rails-assets-tether', '~> 1.3.1'
  gem 'rails-assets-morrisjs'
  gem 'rails-assets-raphael'
  gem 'rails-assets-datatables.net'
  gem 'rails-assets-momentjs'
  gem 'rails-assets-moment-strftime'
end

# gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'ionicons-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 3.0'
gem 'bcrypt', '~> 3.1.7'
gem 'has_secure_token'
# gem 'carrierwave-aws'
#gem 'rmagick', require: false
gem 'imagedrop'
# gem 'summernote-rails'
gem 'prism-rails'
# gem 'liquid-rails', github: 'IAmNaN/liquid-rails'
gem 'liquid'
gem 'redcarpet'

gem 'toastr-rails'
gem 'kaminari'
gem 'font-kit-rails', '~> 1.2.0'

gem 'responders'
gem 'stripe'
gem 'stripe-rails', github: 'hopsoft/stripe-rails'
gem 'js_cookie_rails', '~> 2.1', '>= 2.1.3'

gem 'mandrill-api'


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'omniauth-twitter', github: 'arunagw/omniauth-twitter'
gem 'omniauth-identity'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-instagram'
gem 'omniauth-twitch'
gem 'twitter'
gem 'koala', '~> 2.2'

gem 'rails_12factor'

group :production do
  gem 'airbrake', '~> 5.4'
end

group :development, :test do
  # gem 'foreman'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'byebug'
  gem 'rubocop', require: false
  gem 'simplecov', require: false
  gem 'rails-controller-testing', git: 'https://github.com/rails/rails-controller-testing'
  gem 'rspec-rails', '3.5.0.beta3'
  # gem 'guard-rspec'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'
  gem 'listen', '~> 3.0.5'
  gem 'rails-erd'
  gem 'rails_real_favicon'
end

group :test do
  gem 'database_cleaner'
  gem 'capybara-webkit'
  gem 'capybara'
  gem 'timecop'
  gem 'launchy'
end
