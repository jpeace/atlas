class Presenter
  Binder = require 'atlas/binding/binder'

  init: ->
  model: -> {}
  
  constructor: (@name, view) ->
    @setView(view)
    @init()
  setView: (view) ->
    @view = view
  bindingContext: ->
    presenter: @
    model: @model()
  bind: ->
    Binder.bind(b, @bindingContext()) for b in @view.bindings
  read: ->
    Binder.read(b, @bindingContext()) for b in @view.bindings
  refresh: ->
    @read()
    @bind()