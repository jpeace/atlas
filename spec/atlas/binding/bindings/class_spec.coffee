require 'atlas/binding'

efs = tests.dom.elementFromString

describe 'Class binding', ->
  describe 'when setting values', ->
    it 'correctly adds the class', ->
      el = efs('<div></div>').childNodes[0]
      binding = new atlas.binding.bindings.Class()
      binding.element = el
      binding.setValue('test')
      expect(__$(el).hasClass('test')).toBeTruthy()


    it 'correctly removes the class', ->
      el = efs('<div class="test"></div>').childNodes[0]
      binding = new atlas.binding.bindings.Class()
      binding.element = el
      binding.setValue('', {className:'test'})
      expect(__$(el).hasClass('test')).toBeFalsy()

  describe 'when getting values', ->
    it 'correctly retrieves the class', ->
      el = efs('<div class="test"></div>').childNodes[0]
      binding = new atlas.binding.bindings.Class()
      binding.element = el
      expect(binding.getValue({className:'test'})).toBe('test')
      expect(binding.getValue({className:'not-here'})).toBe('')