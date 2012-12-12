require 'lib/jquery'
require 'lib/underscore'

require 'titan'
require 'core/patches'
require 'core/view'
require 'core/presenter'
require 'core/amplify'

class Bootstrapper
  constructor: (@jq) ->

  bootstrap: ->
    @jq('.view').each (i, el) =>
      presenter = new titan.presenters[el.getAttribute('data-presenter')]()
      presenter.setView(new titan.core.View(el))
      $(el).find('button').each ->
        btnName = this.getAttribute('data-name')
        if btnName? && _.isFunction(presenter["#{btnName}Clicked"])
          $(this).click(presenter["#{btnName}Clicked"])

$(->
  new Bootstrapper(jQuery).bootstrap();
)