ElementWrapper = require 'atlas/dom/element_wrapper'

efs = tests.dom.elementFromString

describe 'Element Wrapper', ->
  it 'can set styles', ->
    el = efs()
    wrapper = new ElementWrapper(el)
    wrapper.setStyle
      'margin-top' : '50px', 
      'border': '1px solid black'

    expect(el.style['margin-top']).toBe('50px')
    expect(el.style.border).toBe('1px solid black')

  it 'can get styles', ->
    el = efs('<div style="background-color:black;"></div>').childNodes[0]
    wrapper = new ElementWrapper(el)

    expect(wrapper.getStyle('background-color')).toBe('black')