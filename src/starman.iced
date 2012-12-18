fs      = require 'fs'
fsextra = require 'fs.extra'
path    = require 'path'
vm      = require 'vm'
cc      = require 'coffeecup'
cs      = require 'coffee-script'
colors  = require 'colors'
{exec}  = require 'child_process'
_       = require 'underscore'

[default_layout_content, default_index_content, default_style_content] = [null, null, null]
[compilePages] = [null]

module.exports.init = ->
  console.log 'Generating skeleton project...'
  try
    fs.writeFile 'layout.html.coffee', default_layout_content, (err) ->
      console.error(err) if err
    console.log '  layout.html.coffee'.green
    console.log '\tThis is the layout template that every page will share.'

    fsextra.mkdirRecursiveSync 'pages'
    fs.writeFile 'pages/index.html.coffee', default_index_content, (err) ->
      console.error(err) if err
    console.log '  pages/'.green
    console.log '\tThis is where coffeecup templates go (like index.html.coffee).'
    console.log '\tThey\'ll be compiled into *.html files in the release folder.'

    fsextra.mkdirRecursiveSync 'scss'
    fs.writeFile 'scss/style.scss', default_style_content, (err) ->
      console.error(err) if err
    console.log '  scss/'.green
    console.log '\tThis is where the SCSS source files go.'
    console.log '\tThey\'ll be compiled into css/*.css files in the release folder.'

    fsextra.mkdirRecursiveSync 'src'
    console.log '  src/'.green
    console.log '\tThis is where all your coffeescript source files will go.'
    console.log '\tThey\'ll be compiled into lib/*.js files in the release folder.'

    fsextra.mkdirRecursiveSync 'static'
    console.log '  static/'.green 
    console.log '\tThis is where all your static resources (images, etc) go.'

  catch e
    console.error e

module.exports.clean = (callback) ->
  await exec 'rm -rf release/', defer()
  console.log "Removed release directory"
  callback?()
  
module.exports.open = (port) ->
  await exec "open http://localhost:#{port}", defer(err)
  console.error err if err?

module.exports.build = (callback) ->
  try
    await exec 'rm -rf release/', defer()
    fsextra.mkdirRecursiveSync 'release'
    await
      fsextra.copyRecursive './static', './release', defer copyErr
      exec 'sass --scss -t expanded --update -f scss:release/css', defer sassErr
      exec 'coffee -c -o release/lib/ src/', defer(csErr, stdout, stderr)
      compilePages defer pagesErr
    if copyErr or sassErr or csErr or pagesErr
      throw copyErr or sassErr or csErr or pagesErr
  catch e
    console.error e
  callback?()

module.exports.watch = (callback) ->
  console.log 'todo: watch'
  callback?()
  
module.exports.serve = (port, callback) ->
  connect = require 'connect'
  staticDir = path.join(process.cwd(), 'release')
  portString = "#{port}".green
  console.log "serving '#{staticDir.green}' on #{portString}"
  connect.createServer(connect.static(staticDir)).listen port
  callback?()

makeReleaseDir = _.memoize (srcDir) ->
  dirChunks = srcDir.split path.sep
  dirChunks[0] = 'release'
  releaseDir = dirChunks.join path.sep
  fsextra.mkdirRecursiveSync releaseDir
  return releaseDir

ccupOptions = format: true
error = (err) ->
  if err?
    console.log err
    return true
  return false

compileLayout = (callback) ->
  console.log "compiling layout..."
  try
    layoutFileContents = fs.readFileSync('layout.html.coffee').toString()
    layoutTemplate = cc.compile layoutFileContents, ccupOptions
    callback? layoutTemplate
  catch e
    console.error "failed to compile 'layout.html.coffee':"
    console.error e
    callback?()

buildOutputTemplateFilePath = (sourcePath) ->
  dirChunks = sourcePath.split path.sep
  dirChunks.shift()
  fileChunks = dirChunks.pop().split '.'
  fileChunks.pop()
  path.join 'release', dirChunks.join(path.sep), fileChunks.join '.'
  
compilePage = (file, layoutTemplate) ->
  return if path.extname(file) isnt '.coffee'
  outputFilePath = buildOutputTemplateFilePath file
  console.log "\t#{file} -> #{outputFilePath}"

  try
    pageContents = fs.readFileSync(file).toString()
    compiledContents = cs.compile pageContents, bare: true
    context = {}
    vm.runInNewContext compiledContents, context

    for prop, value of context
      continue if typeof value isnt 'function'
      context[prop] = cc.render value, context

    results = layoutTemplate context
    fs.writeFile outputFilePath, results, 'utf-8'
  catch e
    console.error e
    
compilePages = (callback) ->
  try
    err = null
    await compileLayout defer(layoutTemplate)
    if not layoutTemplate?
      callback? "couldn't compile layout.html.coffee"
      return

    options = followLinks: false
    walker = fsextra.walk 'pages', options
    walker.on 'file', (root, fileStats, next) ->
      makeReleaseDir root
      compilePage "#{root}/#{fileStats.name}", layoutTemplate
      next()
    walker.on "end", () ->

    if error err
      callback? err
    else
      callback?()
  catch e
    callback? e



default_layout_content = """
doctype 5
html class: 'no-js', ->
  head ->
    meta charset: 'utf-8'
    meta 'http-equiv': 'X-UA-Compatible', content: 'IE=edge,chrome=1'
    title ''
    link rel: 'stylesheet', href: '/css/style.css'
  body ->
    ie 'IE7', ->
      p '.chromeframe', 'You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browswer</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.'
    div -> @body

"""
default_index_content = """
body = ->
  p 'Welcome to Starman'

"""
default_style_content = """
body {
  font-size: 1em;
  line-height: 1.4;
}

"""
