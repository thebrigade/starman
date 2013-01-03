w       = require 'watch'
path    = require 'path'
fs      = require 'fs'
{exec}  = require 'child_process'
_       = require 'underscore'
colors  = require 'colors'
star    = '\u2606'.red

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
  
  fileChangeCallback = (f) ->
    console.log "detected change: #{f}"
    lazyBuild()
  
  dirs = ['pages', 'src', 'static', 'scss']
  opts =
    persistent: true
    interval: 511
  
  console.log 'watching for changes...'
  watchDir = (dir) ->
    dirPath = path.join(process.cwd(), dir)
    w.createMonitor dirPath, (monitor) ->
      monitor.on 'created', fileChangeCallback
      monitor.on 'changed', fileChangeCallback
      monitor.on 'removed', fileChangeCallback
  watchDir dir for dir in dirs
  fs.watchFile 'layout.html.coffee', opts, lazyBuild
  
  callback?()
