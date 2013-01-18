doctype 5
html dir: 'ltr', lang: 'en', class: 'no-js', ->
  head ->
    meta charset: 'utf-8'
    title ''
    meta 'http-equiv': 'X-UA-Compatible', content: 'IE=edge,chrome=1'
    meta name: 'description', content: 'Site description'
    meta name: 'viewport', content: 'width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no'
    link rel: 'icon', href: '/favicon.png'
    link rel: 'stylesheet', href: '/css/style.css'
    script src: '/lib/vendor/modernizr-2.6.2.min.js'
  body ->
    ie 'IE7', ->
      p '.chromeframe', 'You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browswer</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.'
    header ->
      @header
    div class: 'main', role: 'main', -> 
      @body
    footer ->
      @footer
    script src: '//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js'
    coffeescript ->
      document.write('<script src="/lib/vendor/jquery-1.8.3.min.js"><\/script>') if not window.jQuery?
    script src: '/lib/plugins.js'
    script src: '/lib/scripts.js'