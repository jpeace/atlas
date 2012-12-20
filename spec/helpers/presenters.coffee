atlas.ensure_namespace('presenters').One = 
  class PresenterOne extends atlas.core.Presenter
    constructor: ->
      @name = 'One'

    value: ->
      5
      
atlas.ensure_namespace('presenters').Two = 
  class PresenterTwo extends atlas.core.Presenter
    constructor: ->
      @name = 'Two'
      @user =
        name: 'Bob Golly'

    model: ->
      value: 5

atlas.ensure_namespace('presenters.ns').Two = 
  class PresenterTwo extends atlas.core.Presenter
    constructor: ->
      @name = 'Two'

    value: ->
      5