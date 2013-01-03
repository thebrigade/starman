module.exports.init = require './init'
module.exports.serve = require './serve'
module.exports.build = require './build'
module.exports.watch = require './watch'

{exec}  = require 'child_process'

module.exports.clean = (callback) ->
  await exec 'rm -rf release/', defer()
  console.log "Removed release directory"
  callback?()

module.exports.open = (port) ->
  await exec "open http://localhost:#{port}", defer(err)
  console.error err if err?
