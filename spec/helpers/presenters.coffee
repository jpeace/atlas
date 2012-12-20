atlas.ensure_namespace('presenters').One = 
  class PresenterOne extends atlas.core.Presenter
    constructor: ->
      @name = 'One'

    isHidden: ->
      'yes'

    admin: ->
      false

    value: ->
      5
      
atlas.ensure_namespace('presenters').Two = 
  class PresenterTwo extends atlas.core.Presenter
    constructor: ->
      @name = 'Two'
      @user =
        firstName: 'Bob'

    hidden: ->
      'no'

    isAdmin: ->
      true

    model: ->
      value: 5
      user: @user

atlas.ensure_namespace('presenters.ns').Two = 
  class PresenterTwo extends atlas.core.Presenter
    constructor: ->
      @name = 'Two'

    value: ->
      5