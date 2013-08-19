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
      presenter.refresh()
    @

  hookEvents: (presenter)->
    eventsToVerbs = 
      click : 'Clicked'
      dblclick : 'DoubleClicked'
      focus : 'GotFocus'
      blur : 'LostFocus'

    for el in __$(presenter.view.root).elementsWithAttribute('data-name')
      controlName = el.getAttribute('data-name')
      for evt, verb of eventsToVerbs
        if _.isFunction(presenter["#{controlName}#{verb}"])
          __$(el).addEvent(evt, presenter["#{controlName}#{verb}"])

__$(->
  new Bootstrapper(window.document.documentElement).bootstrap();
)

return Bootstrapper