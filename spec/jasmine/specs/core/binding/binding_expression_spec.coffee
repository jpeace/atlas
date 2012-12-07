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
backgroundColorBindings = ->
  getBindings('background-color:value')

describe 'Binding Expression', ->
  it 'throws an exception for unrecognized properties', ->
    expect(new titan.core.binding.BindingExpression('bad:value')).toThrow()

  describe 'with a simple expression', ->
    it 'parses the expression', ->
      expect(simpleBindings().length).toBe(1)

    it 'uses a default bound attribute of display', ->
      expect(simpleBindings()[0].bound).toBe(titan.core.binding.display)

  describe 'when binding the display property', ->
    it 'correctly sets the bound attribute', ->
      expect(displayBindings()[0].bound).toBe(titan.core.binding.display)

    it 'correctly determines targets', ->
      expect(displayBindings()[0].targets).toBe([titan.core.binding.model, titan.core.binding.presenter])

    it 'correctly determines properties', ->
      expect(displayBindings()[0].properties).toBe(['value'])

  describe 'when binding to the class property', ->
    it 'correctly sets the bound attribute', ->
      expect(classBindings()[0].bound).toBe(titan.core.binding.class)

    it 'correctly determines targets', ->
      expect(classBindings()[0].targets).toBe([titan.core.binding.presenter, titan.core.binding.model])

    it 'correctly determines properties', ->
      expect(classBindings()[0].properties).toBe(['isValue', 'shouldValue'])
  
  describe 'when binding to the background color property', ->
    it 'correctly sets the bound attribute', ->
      expect(backgroundColorBindings()[0].bound).toBe(titan.core.binding.backgroundColor)

    it 'correctly determines targets', ->
      expect(backgroundColorBindings()[0].targets).toBe([titan.core.binding.presenter, titan.core.binding.model])

    it 'correctly determines properties', ->
      expect(backgroundColorBindings()[0].properties).toBe(['value'])

  it 'supports multiple statements', ->
    expect(multipleStatementBindings().length).toBe(2)