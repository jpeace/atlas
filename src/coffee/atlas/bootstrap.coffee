require 'lib/underscore'

require 'atlas'
require 'atlas/behaviors'
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

      presenter = new ctor(new atlas.core.View(el), @)
      @hookEvents presenter
      @findBehaviors presenter
      presenter.init()

      @presenters.push presenter
    @

  hookEvents: (presenter, options) ->
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

  findBehaviors: (presenter, options) ->
    options ?= {}
    view = options.view ? presenter.view
    
    parseBehaviorExpression = (expression) ->
      matches = /(\w+)\.(\w+)(\(([\w\s]+)\))?/.exec(expression)
      if matches?
        {
          namespace: matches[1],
          behaviorName: matches[2],
          arg: matches[4]
        }
      else
        null
    
    for el in __$(view.root).elementsWithAttribute('data-behavior')
      behaviorInfos = (parseBehaviorExpression(expr) for expr in el.getAttribute('data-behavior').split(';'))
      for bi in behaviorInfos when bi?
        if atlas.behaviors[bi.namespace]?[bi.behaviorName]?
          behavior = new atlas.behaviors[bi.namespace][bi.behaviorName]()
          behavior.configure(el, bi.arg)

__$(->
  new Bootstrapper(window.document.documentElement).bootstrap();
)

return Bootstrapper