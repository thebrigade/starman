// Generated by IcedCoffeeScript 1.4.0a
(function() {
  var colors, path;

  path = require('path');

  colors = require('colors');

  module.exports = function(port, callback) {
    var connect, portString, staticDir;
    connect = require('connect');
    staticDir = path.join(process.cwd(), 'release');
    portString = ("" + port).green;
    console.log("serving '" + staticDir.green + "' on " + portString);
    connect.createServer(connect["static"](staticDir)).listen(port);
    return typeof callback === "function" ? callback() : void 0;
  };

}).call(this);
