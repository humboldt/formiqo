class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  throttle('api/ip', limit: 10, period: 60.seconds) do |req|
    req.ip if req.path.start_with?('/api')
  end

end
