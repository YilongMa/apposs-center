require "redis"
require "redis-namespace"
require "redis-search"
# don't forget change namespace
redis = Redis.new(:host => "127.0.0.1",:port => "6379")
# We suggest you use a special db in Redis, when you need to clear all data, you can use flushdb command to clear them.
redis.select(3)
# Give a special namespace as prefix for Redis key, when your have more than one project used redis-search, this config will make them work fine.
redis = Redis::Namespace.new("apposs:redis_search", :redis => redis)
Redis::Search.configure do |config|
  config.redis = redis
  config.complete_max_length = 100
  config.pinyin_match = true
  # use rmmseg, true to disable it, it can save memroy
  config.disable_rmmseg = false
end
Redis::Search.indexed_models = [:user, :app]
