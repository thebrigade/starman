fs      = require 'fs'
fsextra = require 'fs.extra'

[default_layout_content, default_index_content, default_style_content] = [null, null, null]
module.exports = ->
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
