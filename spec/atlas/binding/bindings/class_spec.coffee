require 'atlas/binding'

efs = tests.dom.elementFromString

describe 'Class binding', ->
  describe 'when setting values', ->
    it 'correctly adds the class', ->
      el = efs('<div></div>').childNodes[0]
      binding = new atlas.binding.bindings.Class()
      binding.element = el
      binding.baseProperty = 'test'
      binding.setValue('test')
      expect(__$(el).hasClass('test')).toBeTruthy()


    it 'correctly removes the class', ->
      el = efs('<div class="test"></div>').childNodes[0]
      binding = new atlas.binding.bindings.Class()
      binding.element = el
      binding.baseProperty = 'test'
      binding.setValue('', {className:'test'})
      expect(__$(el).hasClass('test')).toBeFalsy()

  describe 'when getting values', ->
    it 'correctly retrieves the class', ->
      el = efs('<div class="test"></div>').childNodes[0]
      binding = new atlas.binding.bindings.Class()
      binding.element = el
      binding.baseProperty = 'test'
      expect(binding.getValue()).toBe('test')

    it 'returns an empty string if the class does not exist on the element', ->
      el = efs('<div class="test"></div>').childNodes[0]
      binding = new atlas.binding.bindings.Class()
      binding.element = el
      binding.baseProperty = 'not-here'
      expect(binding.getValue()).toBe('')
