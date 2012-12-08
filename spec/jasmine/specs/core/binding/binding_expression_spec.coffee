require 'core/binding/binding_expression'

getBindings = (expr) ->
  new titan.core.binding.BindingExpression(expr).bindings
simpleBindings = ->
  getBindings('value')
multipleStatementBindings = ->
  getBindings('value; class:active')
displayBindings = ->
  getBindings('display:value')
classBindings = ->
  getBindings('class:value')
classBindingsWithExplicitAlternate = ->
  getBindings('class:yes|no')
classBindingsWithExplicitProperty = ->
  getBindings('class:value(func)')
classBindingsWithExplicitNegativeProperty = ->
  getBindings('class:value(not func)')
backgroundColorBindings = ->
  getBindings('background-color:value')

describe 'Binding Expression', ->
  it 'throws an exception for unrecognized properties', ->
    expect(-> new titan.core.binding.BindingExpression('bad:value')).toThrow()

  describe 'with a simple expression', ->
    it 'parses the expression', ->
      expect(simpleBindings().length).toBe(1)

    it 'uses a default bound attribute of display', ->
      expect(simpleBindings()[0].boundAttribute).toBe(titan.core.binding.display)

  describe 'when binding the display property', ->
    it 'correctly sets the bound attribute', ->
      expect(displayBindings()[0].boundAttribute).toBe(titan.core.binding.display)

    it 'correctly determines targets', ->
    targets = displayBindings()[0].targets
    expect(targets[0]).toBe(titan.core.binding.model)
    expect(targets[1]).toBe(titan.core.binding.presenter)

    it 'correctly determines properties', ->
      expect(displayBindings()[0].properties).toBe(['value'])

  describe 'when binding to the class property', ->
    it 'correctly sets the bound attribute', ->
      expect(classBindings()[0].boundAttribute).toBe(titan.core.binding.class)

    it 'correctly determines targets', ->
      targets = classBindings()[0].targets
      expect(targets[0]).toBe(titan.core.binding.presenter)
      expect(targets[1]).toBe(titan.core.binding.model)

    it 'correctly determines properties', ->
      expect(classBindings()[0].properties).toBe(['isValue', 'shouldValue', 'value'])

    it 'correctly determines possible values', ->
      expect(classBindings()[0].possibleValues).toBe({true:'value', false:''})

    describe 'when using the explicit alternate syntax', ->
      it 'correctly determines possible values', ->
        expect(classBindingsWithExplicitAlternate()[0].possibleValues).toBe({true:'yes', false:'no'})

    describe 'when using the explicit property syntax', ->
      it 'correctly determines properties', ->
        expect(classBindingsWithExplicitProperty()[0].properties).toBe(['func'])

      it 'correctly determines possible values', ->
        expect(classBindingsWithExplicitProperty()[0].possibleValues).toBe({true:'value', false:''})

    describe 'when using the explicit negative property syntax', ->
      it 'correctly determines possible values', ->
        expect(classBindingsWithExplicitNegativeProperty()[0].possibleValues).toBe({true:'', false:'value'})
  
  describe 'when binding to the background color property', ->
    it 'correctly sets the bound attribute', ->
      expect(backgroundColorBindings()[0].boundAttribute).toBe(titan.core.binding.backgroundColor)

    it 'correctly determines targets', ->
      targets = backgroundColorBindings()[0].targets
      expect(targets[0]).toBe(titan.core.binding.presenter)
      expect(targets[1]).toBe(titan.core.binding.model)

    it 'correctly determines properties', ->
      expect(backgroundColorBindings()[0].properties).toBe(['value'])

  it 'supports multiple statements', ->
    expect(multipleStatementBindings().length).toBe(2)