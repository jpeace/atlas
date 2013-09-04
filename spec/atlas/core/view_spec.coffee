require 'atlas/core/view'

efs = tests.dom.elementFromString

describe 'View', ->
  describe 'when initializing', ->
    it 'builds all bindings', ->
      view = new atlas.core.View(efs(tests.dom.simpleView))
      expect(view.bindings.length).toBe(3)

    it 'correctly assigns elements to bindings', ->
      el = efs(tests.dom.simpleView)
      div = el.getElementsByTagName('div')[0]
      span = el.getElementsByTagName('span')[0]
      
      view = new atlas.core.View(el)
      divBinding = _.find(view.bindings, (b) -> b.properties[0] is 'name')
      spanBinding = _.find(view.bindings, (b) -> b.properties[0] is 'age')

      expect(divBinding.element).toEqual(div)
      expect(spanBinding.element).toEqual(span)

    it 'handles nested bindings correctly', ->
      view = new atlas.core.View(efs(tests.dom.nestedView))
      expect(view.bindings.length).toBe(1)
      expect(view.bindings[0].properties[0]).toBe('city')
      expect(view.bindings[0].modelPath).toBe('user.contact')

    it 'picks up formatters for display bindings', ->
      el = efs(tests.dom.simpleView)
      view = new atlas.core.View(el)
      binding = _.find(view.bindings, (b) -> b.properties[0] is 'name')
      
      expect(binding.format).toBeDefined()
      expect(_.isObject(binding.format.source)).toBe(true)
      expect(binding.format.method).toBe('emphasize')
      expect(binding.format.args).toBe('!!!')