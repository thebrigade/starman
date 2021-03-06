// Generated by IcedCoffeeScript 1.4.0a
(function() {
  var colors, fs, iced, path, pjson, program, star, starman, __iced_k, __iced_k_noop,
    __slice = [].slice;

  iced = {
    Deferrals: (function() {

      function _Class(_arg) {
        this.continuation = _arg;
        this.count = 1;
        this.ret = null;
      }

      _Class.prototype._fulfill = function() {
        if (!--this.count) return this.continuation(this.ret);
      };

      _Class.prototype.defer = function(defer_params) {
        var _this = this;
        ++this.count;
        return function() {
          var inner_params, _ref;
          inner_params = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
          if (defer_params != null) {
            if ((_ref = defer_params.assign_fn) != null) {
              _ref.apply(null, inner_params);
            }
          }
          return _this._fulfill();
        };
      };

      return _Class;

    })(),
    findDeferral: function() {
      return null;
    },
    trampoline: function(_fn) {
      return _fn();
    }
  };
  __iced_k = __iced_k_noop = function() {};

  program = require('commander');

  colors = require('colors');

  starman = require('./index');

  star = '\u2606'.red;

  path = require('path');

  fs = require('fs');

  pjson = require(path.join(path.dirname(fs.realpathSync(__filename)), '../package.json'));

  program.version(pjson.version);

  program.command('init').description('Set up a new project with the appropriate directory structure. Run this within your new project\'s root directory.').action(function(options) {
    return starman.init();
  });

  program.command('clean').description('Nuke the release/ directory (don\'t worry, its all regenerated anyway).').action(function(options) {
    return starman.clean();
  });

  program.command('build').description('Compile everything into the release directory.').action(function(options) {
    return starman.build();
  });

  program.command('watch').description('Keep watching for changes and then compile everything into the release directory. (Blocks)').action(function(options) {
    starman.build();
    return starman.watch();
  });

  program.command('serve').description('Throw up a server on $port to serve up everything in the release directory. (Blocks)').option('-p, --port [port]', 'The port with which to serve upon. Default is 8080.', parseInt).option('-d, --dont-open', 'Don\'t open the url after launching.').on("--help", function() {}).action(function(options) {
    var port, portString;
    port = options.port || 8080;
    portString = ("" + port).green;
    starman.serve(port);
    if (!options.dontOpen) return starman.open(port);
  });

  program.command('dev').description('Throw up a server, watch for changes, and open the site in the default browser. Great for speedy development. (Blocks)').option('-p, --port [port]', 'The port with which to serve upon. Default is 8080.', parseInt).option('-d, --dont-open', 'Don\'t open the url after launching.').on("--help", function() {}).action(function(options) {
    var port, ___iced_passed_deferral, __iced_deferrals, __iced_k,
      _this = this;
    __iced_k = __iced_k_noop;
    ___iced_passed_deferral = iced.findDeferral(arguments);
    port = options.port || 8080;
    starman.watch();
    starman.serve(port);
    (function(__iced_k) {
      __iced_deferrals = new iced.Deferrals(__iced_k, {
        parent: ___iced_passed_deferral,
        filename: "src/cli.iced"
      });
      setTimeout(__iced_deferrals.defer({
        lineno: 66
      }), 1000);
      __iced_deferrals._fulfill();
    })(function() {
      if (!options.dontOpen) return starman.open(port);
    });
  });

  module.exports.run = function() {
    process.stdout.write("" + star + " ");
    return program.parse(process.argv);
  };

}).call(this);
