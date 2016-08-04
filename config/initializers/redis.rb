if ENV["REDISCLOUD_URL"]
  Redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
end