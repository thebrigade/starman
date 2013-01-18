header = ->
  div '.container', ->
    div '.row', ->
      div '.span5', ->
        h1 'h1 Welcome to Starman'
      div '.span7', ->
        nav ->
          a href: '#', 'Nav 1'
          a href: '#', 'Nav 2'
          a href: '#', 'Nav 3'
          a href: '#', 'Nav 4'
          a href: '#', 'Nav 5'

body = ->
  div '.container', ->
    div '.row', ->
      div '.span10', ->
        h2 'h2 Lorem ipsum dolor sit amet'
        p 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed <a href="#">diam nonumy eirmod</a> tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
        h3 'h3 Consetetur sadipscing elitr'
        p 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed <a href="#">diam nonumy eirmod</a> tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
        p 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem <a href="#">ipsum dolor sit amet</a>, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
        h4 'h4 Sed diam voluptua'
        p 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed <a href="#">diam nonumy eirmod</a> tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
        p 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem <a href="#">ipsum dolor sit amet</a>, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
      div '.span2', ->
        h5 'h5 Dolor sit amet'
        ul ->
          li 'List item 1'
          li -> 
            text 'List item 2', ->
            ul ->
              li 'List item 1'
              li 'List item 2'
              li 'List item 3'
              li 'List item 4'
          li 'List item 3'
          li ->
            text 'List item 4', ->
            ol ->
              li 'List item 1'
              li 'List item 2'
              li 'List item 3'
              li 'List item 4'
          li 'List item 5'
        ol ->
          li ->
            text 'List item 1', ->
            ul ->
              li 'List item 1'
              li 'List item 2'
              li 'List item 3'
          li 'List item 2'
          li ->
            text 'List item 3', ->
            ol ->
              li 'List item 1'
              li 'List item 2'
              li 'List item 3'
              li 'List item 4'
          li 'List item 4'
          li 'List item 5'

footer = ->
  div '.container', ->
    div '.row', ->
      div '.span5', ->
        h6 'h6 diam nonumy eirmod tempor'
        p '&copy; 2013'
      div '.span7', ->
        nav ->
          a href: '#', 'Nav 1'
          a href: '#', 'Nav 2'
          a href: '#', 'Nav 3'
          a href: '#', 'Nav 4'
          a href: '#', 'Nav 5'
