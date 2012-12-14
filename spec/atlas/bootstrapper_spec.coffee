Bootstrapper = atlas.Bootstrapper
elementFromString = tests.dom.elementFromString
simpleDocument = tests.dom.simpleDocument

describe 'Bootstrapper', ->
  it 'finds all presenters', ->
    el = elementFromString(simpleDocument)
    b = new Bootstrapper(el)
    expect(b.presenters.length).toBe(2)
    expect(b.presenters[0].name).toBe('PresenterOne')
    expect(b.presenters[1].name).toBe('PresenterTwo')