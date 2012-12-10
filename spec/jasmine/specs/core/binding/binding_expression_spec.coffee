require 'core/binding'

getBindings = (expr) ->
  new titan.core.binding.BindingExpression(expr).bindings
simpleBinding = ->
  getBindings('value')[0]
multipleStatementBindings = ->
  getBindings('value; class:active')
displayBinding = ->
  getBindings('display:value')[0]
classBinding = ->
  getBindings('class:value')[0]
classBindingWithExplicitValue = ->
  getBindings('class:yes|no')[0]
classBindingWithExplicitSourceProperty = ->
  getBindings('class:value(func)')[0]
classBindingWithExplicitNegatedSourceProperty = ->
  getBindings('class:value(not func)')[0]
backgroundColorBinding = ->
  getBindings('background-color:value')[0]

describe 'Binding Expression', ->
  it 'throws an exception for unrecognized properties', ->
    expect(-> new titan.core.binding.BindingExpression('bad:value')).toThrow()

  describe 'with a simple expression', ->
    it 'uses a default target of display', ->
      expect(simpleBinding().target).toBe(titan.core.binding.display)

  describe 'when binding the display target', ->
    it 'correctly sets the target', ->
      expect(displayBinding().target).toBe(titan.core.binding.display)

    it 'correctly determines sources', ->
      sources = displayBinding().sources
      expect(sources[0]).toBe(titan.core.binding.model)
      expect(sources[1]).toBe(titan.core.binding.presenter)

    it 'correctly determines properties', ->
      expect(displayBinding().properties).toBe(['value'])

  describe 'when binding the class target', ->
    it 'correctly sets the target', ->
      expect(classBinding().target).toBe(titan.core.binding.class)

    it 'correctly determines sources', ->
      sources = classBinding().sources
      expect(sources[0]).toBe(titan.core.binding.presenter)
      expect(sources[1]).toBe(titan.core.binding.model)

    it 'correctly determines properties', ->
      expect(classBinding().properties).toBe(['isValue', 'shouldValue', 'value'])

    it 'correctly determines possible values', ->
      expect(classBinding().possibleValues).toBe({true:'value', false:''})

    describe 'when using the explicit value syntax', ->
      it 'correctly determines possible values', ->
        expect(classBindingWithExplicitValue().possibleValues).toBe({true:'yes', false:'no'})

    describe 'when using the explicit source property syntax', ->
      it 'correctly determines properties', ->
        expect(classBindingWithExplicitSourceProperty().properties).toBe(['func'])

      it 'correctly determines possible values', ->
        expect(classBindingWithExplicitProperty().possibleValues).toBe({true:'value', false:''})

    describe 'when using the explicit negated source property syntax', ->
      it 'correctly determines possible values', ->
        expect(classBindingWithExplicitNegatedSourceProperty().possibleValues).toBe({true:'', false:'value'})
  
  describe 'when binding to the background color property', ->
    it 'correctly sets the target', ->
      expect(backgroundColorBinding().target).toBe(titan.core.binding.backgroundColor)

    it 'correctly determines sources', ->
      sources = backgroundColorBinding().sources
      expect(sources[0]).toBe(titan.core.binding.presenter)
      expect(sources[1]).toBe(titan.core.binding.model)

    it 'correctly determines properties', ->
      expect(backgroundColorBinding().properties).toBe(['value'])

  it 'supports multiple statements', ->
    expect(multipleStatementBindings().length).toBe(2)