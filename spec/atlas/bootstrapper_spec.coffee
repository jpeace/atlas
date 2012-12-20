Bootstrapper = require 'atlas/bootstrap'

elementFromString = tests.dom.elementFromString
simpleDocument = tests.dom.simpleDocument
namespacedDocument = tests.dom.namespacedDocument

getBootstrapper = (html) ->
  b = new Bootstrapper(elementFromString(html))
  b.bootstrap()
  return b

describe 'Bootstrapper', ->
  it 'finds all presenters', ->
    b = getBootstrapper(simpleDocument)
    expect(b.presenters.length).toBe(2)
    expect(b.presenters[0].name).toBe('One')
    expect(b.presenters[1].name).toBe('Two')

  it 'finds namespaced presenters', ->
    b = getBootstrapper(namespacedDocument)
    expect(b.presenters.length).toBe(2)
    expect(b.presenters[0].name).toBe('One')
    expect(b.presenters[1].name).toBe('ns.Two')