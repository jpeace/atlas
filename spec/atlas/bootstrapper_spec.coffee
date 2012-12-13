elementFromString = tests.dom.elementFromString
simpleDocument = tests.dom.simpleDocument

describe 'Bootstrapper', ->
  it 'finds all presenters', ->
    doc = elementFromString(simpleDocument)
    console.log(doc.getElementsByTagName('div')[0].hasAttribute('data-presenter'))
    expect(true).toBe(false)