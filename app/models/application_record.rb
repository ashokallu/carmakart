class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # This is a bug in Rails 6, its not loading 'redis-objects' gem into bundle at all.
  # Redis::Objects is used in ActiveRecord only, so, requiring it here.
  # Ideally, this should be config/initializers, but there too, it did not work, so kept here.
  begin
    require 'redis-objects'
  rescue LoadError => e
    dir_path = File.expand_path('vendor/git/redis-objects-master', Rails.root)
    lib_path = File.join(dir_path, "lib")
    $: << lib_path if Dir.exists?(lib_path)
    require 'redis-objects'
  end
end
