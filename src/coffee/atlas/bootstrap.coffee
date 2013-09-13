require 'lib/underscore'

require 'atlas'
require 'atlas/core/patches'
require 'atlas/core/view'
require 'atlas/core/presenter'
require 'atlas/dom'
require 'atlas/helpers'

class Bootstrapper
  constructor: (@element) ->
    @element ?= __$('')
    @presenters = []

  bootstrap: ->
    for el in __$(@element).elementsWithAttribute('data-presenter')
      presenterName = el.getAttribute('data-presenter')
      ctor = __.getProperty(atlas.presenters, presenterName, {followFunctions:false})
      throw new Error("Could not find presenter #{presenterName}") unless ctor?

      presenter = new ctor(presenterName, new atlas.core.View(el), @)
      @hookEvents presenter
      presenter.init()

      @presenters.push presenter
    @

  hookEvents: (presenter, options)->
    options ?= {}
    view = options.view ? presenter.view
    for el in __$(view.root).elementsWithAttribute('data-name')
      controlName = el.getAttribute('data-name')
      for evt, verb of atlas.dom.eventsToVerbs
        callback = presenter["#{controlName}#{verb}"]
          
        if _.isFunction(callback)
          createWrapper = (callback) ->
            (e) =>
              presenter.read()
              item = if options.itemAccessor?
                __.getProperty(options.itemAccessor.source, options.itemAccessor.path)
              eventInfo = {
                event: e,
                item: if (item? and options.itemAccessor?.itemIndex?) then item[options.itemAccessor.itemIndex] else item
              }
              callback(eventInfo)
              presenter.bind()
          __$(el).addEvent(evt, createWrapper(callback))

__$(->
  new Bootstrapper(window.document.documentElement).bootstrap();
)

return Bootstrapper