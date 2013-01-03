fs      = require 'fs'
fsextra = require 'fs.extra'
path    = require 'path'
vm      = require 'vm'
cc      = require 'coffeecup'
cs      = require 'coffee-script'
colors  = require 'colors'
_       = require 'underscore'
{exec}  = require 'child_process'

[compilePages] = [null]

handleProcessOutput = (command, err, stdout, stderr) ->
  console.log stdout if stdout?
  console.error stderr if stderr?
  if err?
    console.error "the #{command} command exited with an error, check the output above for more details"

module.exports = (callback) ->
  try
    await exec 'rm -rf release/', defer()
    fsextra.mkdirRecursiveSync 'release'
    await
      fsextra.copyRecursive './static', './release', defer copyErr
      exec 'sass --scss -t expanded --update -f scss:release/css', defer(sassErr, sassStdout, sassStderr)
      exec 'coffee -c -o release/lib/ src/', defer(csErr, csStdout, csStderr)
      compilePages defer(pagesErr)
    handleProcessOutput 'copy', copyErr
    handleProcessOutput 'sass', sassErr, sassStdout, sassStderr
    handleProcessOutput 'coffee', csErr, csStdout, csStderr
    handleProcessOutput 'compilePages', pagesErr
  catch e
    console.error e
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
