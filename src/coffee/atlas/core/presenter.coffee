class Presenter
  model: ->
  
  constructor: (view) ->
    @setView(view)
  setView: (view) ->
    @view = view
  bindingContext: ->
    view: @view
    presenter: this

  bind: ->
  read: ->