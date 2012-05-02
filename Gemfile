source 'http://rubygems.org'

gem 'rails', '~> 3.0.10'

gem 'sqlite3'
gem 'dynamic_form'

gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  gem 'guard'
  gem 'guard-minitest'
  gem 'guard-passenger'
  gem 'guard-bundler'
  gem 'guard-shell'
  gem 'guard-migrate'
  gem 'guard-cucumber'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'minitest', '~> 2.11.0'
  gem 'rr'
  gem 'rb-inotify' if RUBY_PLATFORM =~ /linux/i
  gem 'libnotify' if RUBY_PLATFORM =~ /linux/i
  gem 'activerecord-nulldb-adapter', 
      :git => "git://github.com/avdi/nulldb.git"
end

gem 'unicorn'
