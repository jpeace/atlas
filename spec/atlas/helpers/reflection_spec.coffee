getObject = ->
  prop1: 'value'
  nested:
    prop2: 'nested'
  func1: ->
    prop3:
      func2: -> 'function'

describe 'Reflection helpers', ->
  describe 'properties', ->
    it 'can get simple properties', ->
      expect(__.getProperty(getObject(), 'prop1')).toBe('value')

    it 'can get nested properties', ->
      expect(__.getProperty(getObject(), 'nested.prop2')).toBe('nested')

    it 'follows functions', ->
      expect(__.getProperty(getObject(), 'func1.prop3.func2')).toBe('function')

    it 'can be configured to not follow functions', ->
      expect(__.getProperty(getObject(), 'func1.prop3', {followFunctions:false})).toBeNull()

    it 'returns null when getting a property that does not exist', ->
      expect(__.getProperty(getObject(), 'gone')).toBeNull()
      expect(__.getProperty(getObject(), 'not.here')).toBeNull()

    it 'can set simple properties', ->
      obj = getObject()
      __.setProperty(obj, 'prop1', 'changed')
      expect(obj.prop1).toBe('changed')

    it 'can set nested properties', ->
      obj = getObject()
      __.setProperty(obj, 'nested.prop2', 'changed')
      expect(obj.nested.prop2).toBe('changed')

    it 'throws an exception when attempting to set a function', ->
      expect(-> __.setProperty(getObject(), 'func1', 'value')).toThrow()

    it 'throws an exception when setting a property that does not exist', ->
      expect(-> __.setProperty(getObject(), 'not.here', 'value')).toThrow()