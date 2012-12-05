require 'core/binding/binding_expression'

describe 'Binding Expression', ->
  it 'parses a simple expression', ->
    bindings = new titan.core.binding.BindingExpression('property:value').bindings
    expect(bindings.length).toBe(1)
    #expect(bindings[0].property).toBe(titan.core.binding.3