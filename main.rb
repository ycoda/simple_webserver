require 'webrick'
require_relative 'config'
require_relative 'app/router'

server = WEBrick::HTTPServer.new(
    Port: AppConfig::PORT,
    ServerName: AppConfig::NAME
)

Router.draw(server)
puts "#{AppConfig::NAME} is running on port #{AppConfig::PORT}..."
trap('INT') { server.shutdown }
server.start