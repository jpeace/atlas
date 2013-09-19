class Presenter
  Binder = require 'atlas/binding/binder'

  init: ->
  model: -> {}
  
  constructor: (@view, @bootstrapper) ->
  bindingContext: ->
    presenter: @
    model: @model()
  bind: =>
    Binder.bind(b, @bindingContext()) for b in @view.bindings
  read: =>
    Binder.read(b, @bindingContext()) for b in @view.bindings