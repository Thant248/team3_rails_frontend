# config/initializers/redis.rb
module RedisClient
  class << self
    def redis
      @redis ||= Redis.new(url: "redis://redis:6379/0")
    end
  end
end