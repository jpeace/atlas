require 'jquery'
require 'underscore'

require 'titan'
require 'core/view'
require 'core/presenter'
require 'core/amplify'

titan.define class Bootstrapper
  constructor: (@jq) ->
    @presenters = []

  bootstrap: ->
    @jq('.view').each (i, el) =>
      presenter = new titan.presenters[el.getAttribute('data-presenter')]()
      presenter.setView(new titan.classes.View(el))
      $(el).find('button').each ->
        btnName = this.getAttribute('data-name')
        if btnName? && _.isFunction(presenter["#{btnName}Clicked"])
          $(this).click(presenter["#{btnName}Clicked"])
      @presenters.push(presenter)

$(->
  new Bootstrapper(jQuery).bootstrap();
)