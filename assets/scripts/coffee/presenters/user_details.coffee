class UserDetails extends titan.core.Presenter
  loadClicked: =>
    __.loadById 5, (data) =>
      @view.bind(data);

  model: ->
    prop1: 'value'
    prop2:
      prop3: 'value'
      prop4: 'value'