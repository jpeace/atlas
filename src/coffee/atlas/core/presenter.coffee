class Presenter
  model: -> {}
  
  constructor: (view) ->
    @setView(view)
  setView: (view) ->
    @view = view
  bindingContext: ->
    presenter: @
    model: @model()

  bind: ->
  read: ->