require 'atlas/dom'

html = '<div></div><p attr="value"></p><span></span>'

describe 'Global DOM function', ->
  it 'is exposed as the symbol __$', ->
    expect(__$).not.toBeNull()

  it 'throws an exception with an invalid argument', ->
    expect(-> __$(1)).toThrow()

  it 'can build elements from HTML strings', ->
    expect(__$(html).childNodes.length).toBe(3)

  it 'returns a search object when given an element', ->
    element = tests.dom.elementFromString(html)
    expect(__$(element).elementsWithAttribute('attr').length).toBe(1)