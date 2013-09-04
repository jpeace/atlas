require 'atlas/binding'

getBinding = (sourceExpression, context) ->
  new atlas.binding.Base(sourceExpression)
simpleBinding = ->
  getBinding('value')
deeperBinding = ->
  getBinding('some.value')
bindingWithExplicitValues = ->
  getBinding('yes|no')
bindingWithExplicitSourceProperty = ->
  getBinding('value(func)')
bindingWithExplicitNegatedSourceProperty = ->
  getBinding('value(not func)')
bindingWithExplicitValueAndSourceProperty = ->
  getBinding('on|off(func)')
bindingWithMode = ->
  getBinding('value as collection')


describe 'Bindings', ->
  it 'throws an exception with a malformed source expression', ->
    expect(-> new atlas.binding.Base('bad value')).toThrow()

  it 'preserves the base property name', ->
    binding = simpleBinding()
    expect(binding.baseProperty).toBe('value')

  describe 'source expressions', ->
    it 'can be simple', ->
      binding = simpleBinding()
      expect(binding.properties.length).toBe(1)
      expect(binding.properties[0]).toBe('value')
      expect(binding.possibleValues).toBeNull()
      expect(binding.mode).toBe(atlas.binding.modes.simple)

    it 'can reference deeper properties', ->
      binding = deeperBinding()
      expect(binding.properties.length).toBe(1)
      expect(binding.properties[0]).toBe('some.value')

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

    it 'can specify a binding mode', ->
      binding = bindingWithMode()
      expect(binding.properties.length).toBe(1)
      expect(binding.properties[0]).toBe('value')
      expect(binding.mode).toBe(atlas.binding.modes.collection)