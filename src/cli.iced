program = require 'commander'
colors  = require 'colors'
starman = require './index'
star    = '\u2606'.red
path    = require 'path'
fs      = require 'fs'
pjson   = require path.join(path.dirname(fs.realpathSync(__filename)), '../package.json')
program
  .version pjson.version

program
  .command('init')
  .description('Set up a new project with the appropriate directory structure. Run this within your new project\'s root directory.')
  .action((options) ->
    starman.init()
  )

program
  .command('clean')
  .description('Nuke the release/ directory (don\'t worry, its all regenerated anyway).')
  .action((options) ->
    starman.clean()
  )

program
  .command('build')
  .description('Compile everything into the release directory.')
  .action((options) ->
    starman.build()
  )

program
  .command('watch')
  .description('Keep watching for changes and then compile everything into the release directory. (Blocks)')
  .action((options) ->
    starman.watch()
  )

program
  .command('serve')
  .description('Throw up a server on $port to serve up everything in the release directory. (Blocks)')
  .option('-p, --port [port]', 'The port with which to serve upon. Default is 8080.', parseInt)
  .option('-d, --dont-open', 'Don\'t open the url after launching.')
  .on("--help", ->
    # custom help
  ).action((options) ->
    port = options.port or 8080
    portString = "#{port}".green
  
    starman.serve port
    starman.open port unless options.dontOpen
  )

program
  .command('dev')
  .description('Throw up a server, watch for changes, and open the site in the default browser. Great for speedy development. (Blocks)')
  .option('-p, --port [port]', 'The port with which to serve upon. Default is 8080.', parseInt)
  .option('-d, --dont-open', 'Don\'t open the url after launching.')
  .on("--help", ->
    # custom help
  ).action((options) ->
    port = options.port or 8080
    starman.watch()
    starman.serve port
    await setTimeout defer(), 1000
    starman.open port unless options.dontOpen
  )

module.exports.run = ->
  process.stdout.write "#{star} "
  program.parse process.argv
