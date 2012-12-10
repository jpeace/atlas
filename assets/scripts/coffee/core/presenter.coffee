class Presenter
  setView: (view) ->
    @view = view
  bindingContext: ->
    view: @view
    presenter: this