class UserDetails extends titan.core.Presenter
  loadClicked: =>
    __.loadById 5, (data) =>
      @view.bind(data);