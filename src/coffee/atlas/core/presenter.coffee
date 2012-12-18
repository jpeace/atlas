class Presenter
  constructor: (view) ->
    @setView(view)
    
  setView: (view) ->
    @view = view
  bindingContext: ->
    view: @view
    presenter: this
  model: ->
  bind: ->
  read: ->