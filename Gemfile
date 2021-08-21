source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
# gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'rails'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.2.3'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
gem 'sprockets', '~> 3.7.2'
gem 'sprockets-rails', :require => 'sprockets/railtie'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Pagination
gem 'kaminari' # Scope & Engine based, clean, powerful, customizable paginator for Rails 4+.

# gem 'dalli' # High performance memcached client for Ruby.

# API
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder.
gem 'jbuilder', '~> 2.7'
# ActiveModel::Serializers allows you to generate your JSON in an object-oriented and convention-driven manner.
gem 'active_model_serializers'
gem 'jsonapi.rb'
# object serialization to 'jsonapi.rb' is powered by JSON:API Serializer, was fast_jsonapi
# gem 'jsonapi-serializer' # A dependency gem for 'jsonapi.rb' gem.
# A Ruby framework for rapid API development with great conventions.
gem 'grape'
# Provides a Formatter for the Grape API DSL to emit objects serialized with 'active_model_serializers'.
gem 'grape-active_model_serializers'
gem 'oj' # The fastest JSON parser and object serializer (Optimised JSON).
# API documentation
gem 'grape-swagger'
gem 'grape-path-helpers'
gem 'grape-route-helpers'
gem 'grape-entity'
gem 'grape_logging'
gem 'grape_on_rails_routes'
gem 'rswag-ui'
gem 'rack-cors', '~> 1.0.6', require: 'rack/cors'

# Graphql
gem 'graphql'
gem 'graphql-batch', '0.4.3'
# gem 'graphql', '~> 1.11.8'
# NOTE: graphiql-rails v1.5+ doesn't work: https://gitlab.com/gitlab-org/gitlab/issues/31771
# TODO: remove app/views/graphiql/rails/editors/show.html.erb when https://github.com/rmosolgo/graphiql-rails/pull/71 is released:
# https://gitlab.com/gitlab-org/gitlab/issues/31747
# gem 'graphiql-rails', '~> 1.4.10'
gem 'apollo_upload_server', '~> 2.0.2'
gem 'graphql-docs', '~> 1.6.0', group: [:development, :test]
gem 'graphlient', '~> 0.4.0' # Used by BulkImport feature (group::import)

# Redis
gem 'redis' # A Ruby client that tries to match Redis' API one-to-one.
gem 'redis-rails' # Redis for Ruby on Rails.
# Map Redis types directly to Ruby objects. Works with any class or ORM.
# gem 'redis-objects', :path => 'vendor/git/redis-objects-master'
gem 'redis-objects'
gem 'hiredis'
gem 'redis-namespace' # Adds a Redis::Namespace class which can be used to namespace calls to Redis.
# gem 'redis-rack-cache'
# gem 'redis-store'
# gem 'redis-session-store' # A drop-in replacement for e.g. MemCacheStore to store Rails sessions

# Search
gem 'sunspot_rails' # Sunspot::Rails is an extension to the Sunspot library for Solr search.
# optional pre-packaged Solr distribution for use in development. Not for use in production.
gem 'sunspot_solr' # Sunspot::Solr provides a bundled Solr distribution for use with Sunspot.

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Performance Monitoring
  gem 'bullet' # help to kill N+1 queries and unused eager loading.

  # Test Frameworks
  gem 'rspec' # TDD for Ruby
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'pry-rails'

  gem "slim-rails"
  # gem "html2haml"
  # gem "haml2slim"

  # For local/instance variable inspection, pretty stack frame names.
  gem 'awesome_print', '2.0.0.pre2'

  # For better error reporting
  gem 'better_errors'
  gem 'binding_of_caller' # For local/instance variable inspection, pretty stack frame names.

  gem 'paper_trail' # Track changes to your models, for auditing or versioning.
  gem 'annotate'

  # Code Metrics
  gem 'rubocop' # RuboCop is a Ruby code style checking and code formatting tool. It aims to enforce the community-driven Ruby Style Guide. A Ruby static code analyzer and formatter, based on the community Ruby style guide.

  gem 'rails-erd'
  gem 'mini_magick'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'graphiql-rails', group: :development
