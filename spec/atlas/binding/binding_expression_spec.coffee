require 'atlas/binding'

getBindings = (expr) ->
  new atlas.binding.BindingExpression(expr).bindings
simpleBinding = ->
  getBindings('value')[0]
displayBinding = ->
  getBindings('display:value')[0]
classBinding = ->
  getBindings('class:value')[0]
backgroundColorBinding = ->
  getBindings('background-color:value')[0]
multipleStatementBindings = ->
  getBindings('value; class:active')

describe 'Binding Expression', ->
  it 'throws an exception for unrecognized target', ->
    expect(-> new atlas.binding.BindingExpression('bad:value')).toThrow()

  it 'provides parsing context', ->
    context =
      modelPath: 'some.path'
    binding = new atlas.binding.BindingExpression('value', context).bindings[0]
    expect(binding.modelPath).toBe('some.path')

  describe 'with a simple expression', ->
    it 'uses a default target of display', ->
      expect(simpleBinding().target).toBe(atlas.binding.targets.display)

  describe 'when binding the display target', ->
    it 'correctly sets the target', ->
      expect(displayBinding().target).toBe(atlas.binding.targets.display)

    it 'correctly determines sources', ->
      sources = displayBinding().sources
      expect(sources[0]).toBe(atlas.binding.sources.model)
      expect(sources[1]).toBe(atlas.binding.sources.presenter)

    # describe 'with collections', ->


  describe 'when binding the class target', ->
    it 'correctly sets the target', ->
      expect(classBinding().target).toBe(atlas.binding.targets.class)

    it 'correctly determines sources', ->
      sources = classBinding().sources
      expect(sources[0]).toBe(atlas.binding.sources.presenter)
      expect(sources[1]).toBe(atlas.binding.sources.model)

    it 'correctly determines properties', ->
      properties = classBinding().properties
      expect(properties[0]).toBe('isValue')
      expect(properties[1]).toBe('shouldValue')
      expect(properties[2]).toBe('value')
  
  describe 'when binding to the background color property', ->
    it 'correctly sets the target', ->
      expect(backgroundColorBinding().target).toBe(atlas.binding.targets.backgroundColor)

    it 'correctly determines sources', ->
      sources = backgroundColorBinding().sources
      expect(sources[0]).toBe(atlas.binding.sources.presenter)
      expect(sources[1]).toBe(atlas.binding.sources.model)

  it 'supports multiple statements', ->
    bindings = multipleStatementBindings()
    expect(bindings.length).toBe(2)
    expect(bindings[0].target).toBe(atlas.binding.targets.display)
    expect(bindings[1].target).toBe(atlas.binding.targets.class)