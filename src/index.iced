watch  = require 'watch'
fs     = require 'fs'
{exec} = require 'child_process'
_      = require 'underscore'
colors = require 'colors'
star   = '\u2606'.red

module.exports.init = require './init'
module.exports.serve = require './serve'
module.exports.build = require './build'

module.exports.clean = (callback) ->
  await exec 'rm -rf release/', defer()
  console.log "Removed release directory"
  callback?()

module.exports.open = (port) ->
  await exec "open http://localhost:#{port}", defer(err)
  console.error err if err?

module.exports.watch = (callback) ->
  buildWrapper = ->
    process.stdout.write "#{star} "
    module.exports.build()
    
  lazyBuild = _.debounce buildWrapper, 500
  
  fileChangeCallback = (f, curr, prev) ->
    if not curr and not prev
      return
    lazyBuild()

  opts =
    ignoreDotFiles : true
    filter : (f) -> not f.match(/~$/)?
    persistent: true
    interval: 511

  dirs = ['pages', 'src', 'static', 'scss']
  watch.watchTree dir, opts, fileChangeCallback for dir in dirs
  fs.watchFile 'layout.html.coffee', opts, lazyBuild
  
  console.log 'watching for changes...'
  callback?()
