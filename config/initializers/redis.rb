Redis.instance_eval do
  def connect_to_redis!
    uri = URI.parse(ENV["REDIS_URL"] || "redis://localhost:6379")
    $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  end
end

Redis.connect_to_redis!
