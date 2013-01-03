path    = require 'path'
colors  = require 'colors'

module.exports = (port, callback) ->
  connect = require 'connect'
  staticDir = path.join(process.cwd(), 'release')
  portString = "#{port}".green
  console.log "serving '#{staticDir.green}' on #{portString}"
  connect.createServer(connect.static(staticDir)).listen port
  callback?()

