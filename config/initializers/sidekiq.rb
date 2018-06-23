require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], size: ENV['CLIENT_SIZE'] }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], size: ENV['SERVER_SIZE'] }

  Rails.application.config.after_initialize do
    Rails.logger.info("DB Connection Pool size for Sidekiq Server before disconnect is: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
    ActiveRecord::Base.connection_pool.disconnect!

    ActiveSupport.on_load(:active_record) do
      config = Rails.application.config.database_configuration[Rails.env]
      config['reaping_frequency'] = ENV['DATABASE_REAP_FREQ'] || 10 # seconds
      # config['pool'] = ENV['WORKER_DB_POOL_SIZE'] || `
      config['pool'] = ENV["DB_POOL"].to_i - 2 
      ActiveRecord::Base.establish_connection(config)

      Rails.logger.info("DB Connection Pool size for Sidekiq Server is now: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
    end
  end
end