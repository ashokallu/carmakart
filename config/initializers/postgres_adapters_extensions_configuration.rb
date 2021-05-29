ApplicationRecord.connection.instance_eval do
  if extension_available?(:hstore)
    enable_extension(:hstore) unless extension_enabled?(:hstore)
  end
end

