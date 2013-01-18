fs      = require 'fs'
fsextra = require 'fs.extra'
path    = require 'path'

[default_layout_content, default_index_content, default_style_content] = [null, null, null]
module.exports = ->
  initPath = path.normalize __dirname + '/../init'
  console.log "Generating skeleton project from '#{initPath}'"

  try
    await fsextra.copyRecursive initPath, './', defer err
    console.error(err) if err
      
    console.log '  layout.html.coffee'.green
    console.log '\tThis is the layout template that every page will share.'

    console.log '  pages/'.green
    console.log '\tThis is where coffeecup templates go (like index.html.coffee).'
    console.log '\tThey\'ll be compiled into *.html files in the release folder.'

    console.log '  scss/'.green
    console.log '\tThis is where the SCSS source files go.'
    console.log '\tThey\'ll be compiled into css/*.css files in the release folder.'

    console.log '  src/'.green
    console.log '\tThis is where all your coffeescript source files will go.'
    console.log '\tThey\'ll be compiled into lib/*.js files in the release folder.'

    console.log '  static/'.green
    console.log '\tThis is where all your static resources (images, etc) go.'

  catch e
    console.error e
