program = require 'commander'
colors = require 'colors'
starman = require './starman'

todoString = 'todo: '.blue

program
  .version('0.0.1')
  .option('-v, --verbose', 'be chatty.')

program
  .command('init')
  .description('Set up a new project with the appropriate directory structure. Run this within your new project\'s root directory.')
  .action((options) ->
    #todo: grab any options
    starman.init()
  )

program
  .command('build')
  .description('Compile everything into the release directory.')
  .action((options) ->
    #todo: grab any options
    starman.build()
  )

program
  .command('watch')
  .description('Keep watching for changes and then compile everything into the release directory.')
  .action((options) ->
    #todo: grab any options
    starman.watch()
  )

program
  .command('serve')
  .description('Throw up a server on $port to serve up everything in the release directory.')
  .option('-p, --port [port]', 'The port with which to serve upon. Default is 8080.', parseInt)
  .on("--help", ->
    console.log "#{todoString}display help about serve?"
  ).action((options) ->
    port = options.port or 8080
    portString = "#{port}".green
    console.log "serving on #{portString}"
    starman.serve port  
  )

program
  .command('dev')
  .description('Throw up a server, watch for changes, and open the site in the default browser. Great for speedy development.')
  .option('-p, --port [port]', 'The port with which to serve upon. Default is 8080.', parseInt)
  .on("--help", ->
    console.log "todo: display help about dev?"
  ).action((options) ->
    port = options.port or 8080
    portString = "#{port}".green
  
    starman.build()
    
    starman.watch()
    
    starman.serve port
  
    url = "http://localhost:#{port}"
    console.log "#{todoString}open #{url}"
  )

module.exports.run = ->
  program.parse process.argv
