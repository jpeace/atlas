require 'atlas/binding'

efs = tests.dom.elementFromString

describe 'Background color binding', ->
  it 'correctly sets values', ->
    el = efs('<div></div>').childNodes[0]
    binding = new atlas.binding.bindings.BackgroundColor()
    binding.element = el
    binding.setValue('black')

    expect(el.style['background-color']).toBe('black')

  it 'correctly gets values', ->
    el = efs('<div style="background-color:black;">Test</div>').childNodes[0]
    binding = new atlas.binding.bindings.BackgroundColor()
    binding.element = el

    expect(binding.getValue()).toBe('black')