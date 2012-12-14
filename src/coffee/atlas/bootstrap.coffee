require 'lib/jquery'
require 'lib/underscore'

require 'atlas'
require 'atlas/core/patches'
require 'atlas/core/view'
require 'atlas/core/presenter'
  
atlas.Bootstrapper = class Bootstrapper
  presenters: []

  constructor: (@element) ->

  bootstrap: ->
    # @jq('.view').each (i, el) =>
    #   presenter = new atlas.presenters[el.getAttribute('data-presenter')]()
    #   presenter.setView(new atlas.core.View(el))
    #   $(el).find('button').each ->
    #     btnName = this.getAttribute('data-name')
    #     if btnName? && _.isFunction(presenter["#{btnName}Clicked"])
    #       $(this).click(presenter["#{btnName}Clicked"])

$(->
  new atlas.Bootstrapper(window.document.documentElement).bootstrap();
)