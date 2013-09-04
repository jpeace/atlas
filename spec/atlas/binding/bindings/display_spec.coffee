require 'atlas/binding'

efs = tests.dom.elementFromString

describe 'Display binding', ->
  describe 'with display only elements', ->
    # div, span, p, etc. - the negation of atlas.binding.editableElements
    it 'correctly sets values', ->
      el = efs('<div></div>').childNodes[0]
      binding = new atlas.binding.bindings.Display()
      binding.element = el
      binding.setValue('Test')

      expect(el.textContent).toBe('Test')

    it 'correctly gets values', ->
      el = efs('<div>Test</div>').childNodes[0]
      binding = new atlas.binding.bindings.Display()
      binding.element = el

      expect(binding.getValue()).toBe('Test')

  describe 'with editable elements', ->
    # input, textarea, select, etc. - can be changed at atlas.binding.editableElements
    it 'correctly sets values', ->
      el = efs('<input type="text"></input>').childNodes[0]
      binding = new atlas.binding.bindings.Display()
      binding.element = el
      binding.setValue('Test')

      expect(el.value).toBe('Test')

    it 'correctly gets values', ->
      el = efs('<input type="text" value="Test"></input>').childNodes[0]
      binding = new atlas.binding.bindings.Display()
      binding.element = el

      expect(binding.getValue()).toBe('Test')

  describe 'with formatting', ->
    formattedBinding = ->
      el = efs('<div></div>').childNodes[0]
      binding = new atlas.binding.bindings.Display()
      binding.element = el
      binding.format = 
        source: new atlas.formatters.test()
        method: 'emphasize'
        args: '?'
      binding

    it 'uses the format when setting the value', ->
      binding = formattedBinding()
      binding.setValue('what')

      expect(binding.element.textContent).toBe('what?')

    it 'ignores the format for inappropriate types', ->
      binding = formattedBinding()
      binding.setValue(15)

      expect(binding.element.textContent).toBe('15')