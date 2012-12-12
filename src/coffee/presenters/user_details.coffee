class UserDetails extends atlas.core.Presenter
  loadClicked: =>
    # @model.user.firstName = asdfadsf
    @user.firstName = afadsfa
    @event.title = afadfsas

    __.loadById 5, (data) =>
      @user.firstName = data
      @bind()

  model: ->
    user: @user
    event: @event

# @view.bind(@model())