atlas.ensureNamespace('presenters').One = 
  class PresenterOne extends atlas.core.Presenter
    isHidden: ->
      'yes'

    admin: ->
      false

    value: ->
      5

    isFunny: (comedian) ->
      if comedian is 'Richard Pryor' then true else false
      
atlas.ensureNamespace('presenters').Two = 
  class PresenterTwo extends atlas.core.Presenter
    constructor: (name, view) ->
      super(name, view)
      @user =
        firstName: 'Bob'
        friends: {name:'Rob',name:'Gob'}

    hidden: ->
      'no'

    isAdmin: ->
      true

    model: ->
      value: 5
      user: @user

    changeClicked: =>
      @user.firstName = 'Changed'

    otherClicked: =>


atlas.ensureNamespace('presenters.ns').Two = 
  class PresenterTwo extends atlas.core.Presenter
    value: ->
      5