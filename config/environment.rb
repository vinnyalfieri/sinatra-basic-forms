ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])


ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/songs-#{ENV['SINATRA_ENV']}.db"
)

ActiveRecord::Base.logger = nil

require_all 'app'
