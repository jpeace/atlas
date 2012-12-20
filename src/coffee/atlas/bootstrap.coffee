require 'lib/underscore'

require 'atlas'
require 'atlas/core/patches'
require 'atlas/core/view'
require 'atlas/core/presenter'
require 'atlas/dom'
require 'atlas/helpers'

class Bootstrapper
  constructor: (@element) ->
    @presenters = []

  bootstrap: ->
    for el in __$(@element).elementsWithAttribute('data-presenter')
      presenterName = el.getAttribute('data-presenter')
      ctor = __.getProperty(atlas.presenters, presenterName, {followFunctions:false})
      throw new Error("Could not find presenter #{presenterName}") unless ctor?

      presenter = new ctor(presenterName, new atlas.core.View(el))
      @hookEvents presenter
      @presenters.push presenter
    @

  hookEvents: ->

    # @jq('.view').each (i, el) =>
    #   presenter = new atlas.presenters[el.getAttribute('data-presenter')]()
    #   presenter.setView(new atlas.core.View(el))
    #   $(el).find('button').each ->
    #     btnName = this.getAttribute('data-name')
    #     if btnName? && _.isFunction(presenter["#{btnName}Clicked"])
    #       $(this).click(presenter["#{btnName}Clicked"])

__$(->
  new Bootstrapper(window.document.documentElement).bootstrap();
)

return Bootstrapper