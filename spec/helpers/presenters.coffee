atlas.ensure_namespace('presenters').One = class PresenterOne
  name: 'One'

atlas.ensure_namespace('presenters').Two = class PresenterTwo
  name: 'Two'

atlas.ensure_namespace('presenters.ns').Two = class PresenterTwo
  name: 'Two'