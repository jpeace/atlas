require 'atlas/binding'

emptyElement = tests.dom.emptyElement
getBinding = (sourceExpression) ->
  new atlas.binding.bindings.Base(emptyElement, sourceExpression)
simpleBinding = ->
  getBinding('value')
bindingWithExplicitValues = ->
  getBinding('yes|no')
bindingWithExplicitSourceProperty = ->
  getBinding('value(func)')
bindingWithExplicitNegatedSourceProperty = ->
  getBinding('value(not func)')
bindingWithExplicitValueAndSourceProperty = ->
  getBinding('on|off(func)')

describe 'Bindings', ->
  it 'throws an exception when no element is given', ->
    expect(-> new atlas.binding.bindings.Base(null, 'value')).toThrow()

  it 'throws an exception with a malformed source expression', ->
    expect(-> new atlas.binding.bindings.Base(emptyElement, 'bad value')).toThrow()
    
  describe 'source expressions', ->
    it 'can be simple', ->
      binding = simpleBinding()
      expect(binding.properties.length).toBe(1)
      expect(binding.properties[0]).toBe('value')
      expect(binding.possibleValues).toBeNull()
      
    it 'can have explicit values', ->
      binding = bindingWithExplicitValues()
      expect(binding.properties.length).toBe(1)
      expect(binding.properties[0]).toBe('yes')
      expect(binding.possibleValues).toEqual({true:'yes', false:'no'})

    it 'can have an explicit source property', ->
      binding = bindingWithExplicitSourceProperty()
      expect(binding.properties.length).toBe(1)
      expect(binding.properties[0]).toBe('func')
      expect(binding.possibleValues).toEqual({true:'value', false:''})

    it 'can have an explicit negated source property', ->
      binding = bindingWithExplicitNegatedSourceProperty()
      expect(binding.properties.length).toBe(1)
      expect(binding.properties[0]).toBe('func')
      expect(binding.possibleValues).toEqual({true:'', false:'value'})

    it 'can combine explicit values and source properties', ->
      binding = bindingWithExplicitValueAndSourceProperty()
      expect(binding.properties.length).toBe(1)
      expect(binding.properties[0]).toBe('func')
      expect(binding.possibleValues).toEqual({true:'on', false:'off'})