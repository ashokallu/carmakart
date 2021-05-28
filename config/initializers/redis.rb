config = YAML::load(File.open("#{Rails.root}/config/redis.yml"))[Rails.env]

Redis.current = Redis::Namespace.new("#{config['namespace']}".to_sym,
 :redis => Redis.new(config))

Carmakart::CartRedis = Redis::Namespace.new("#{config['cart']['namespace']}",
 redis: Redis.new(config['cart']))