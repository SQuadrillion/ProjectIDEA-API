# if rails.env == "development"
  REDIS = Redis.new(host: "localhost", port: 6379)
# else
  # REDIS = Redis.new(host: "150.95.145.170", port: 6379)
# end
