atlas.ensureNamespace('presenters').One = 
  class PresenterOne extends atlas.core.Presenter
    isHidden: ->
      'yes'

    admin: ->
      false

    value: ->
      5
      
atlas.ensureNamespace('presenters').Two = 
  class PresenterTwo extends atlas.core.Presenter
    constructor: (name, view) ->
      super(name, view)
      @user =
        firstName: 'Bob'

    hidden: ->
      'no'

    isAdmin: ->
      true

    model: ->
      value: 5
      user: @user

atlas.ensureNamespace('presenters.ns').Two = 
  class PresenterTwo extends atlas.core.Presenter
    value: ->
      5