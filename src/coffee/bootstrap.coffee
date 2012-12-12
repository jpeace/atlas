require 'lib/jquery'
require 'lib/underscore'

require 'atlas'
require 'core/patches'
require 'core/view'
require 'core/presenter'
require 'core/amplify'

class Bootstrapper
  constructor: (@jq) ->

  bootstrap: ->
    @jq('.view').each (i, el) =>
      presenter = new atlas.presenters[el.getAttribute('data-presenter')]()
      presenter.setView(new atlas.core.View(el))
      $(el).find('button').each ->
        btnName = this.getAttribute('data-name')
        if btnName? && _.isFunction(presenter["#{btnName}Clicked"])
          $(this).click(presenter["#{btnName}Clicked"])

$(->
  new Bootstrapper(jQuery).bootstrap();
)