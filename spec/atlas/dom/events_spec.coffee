Events = require 'atlas/dom/events'

elementFromString = tests.dom.elementFromString
createEvent = tests.dom.createEvent

state = {}
beforeEach ->
  state =
    val1: 'not changed'

getElement = -> elementFromString('<button>Click</button>')

describe 'DOM Events', ->
  describe 'hooking events', ->
    it 'can hook click events', ->
      el = getElement()
      new Events(el).addEvent('click', -> state.val1 = 'changed')
      el.dispatchEvent(createEvent('click'))
      expect(state.val1).toBe('changed')