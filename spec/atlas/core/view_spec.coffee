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
















  # beforeEach ->
  # afterEach ->

  # this.in_spec = ->
  #   34

  # it 'does something', =>
  #   expect(this.in_spec()).toBe(34)

  # it 'can spy', =>
  #   spyOn(this, 'in_spec').andReturn(35)
  #   expect(this.in_spec()).toBe(35)


  # describe 'with a simple template', ->
  #   _subject = null 
  #   _jq = null
  #   _html = 
  #     '<div data-view="Test">
  #       <div id="name" data-property="name">Bob Golly</div>
  #       <input id="age" data-property="age" value="25" />
  #     </div>'
      
  #   beforeEach ->
  #     _jq = $(_html)
  #     _subject = new atlas.core.View(_jq)

  #   it 'binds to a model', ->
  #     _subject.bind({name:'Jarrod',age:30})
      
  #     expect(_jq.find('#name').html()).toBe 'Jarrod'
  #     expect(_jq.find('#age').val()).toBe '30'

  #   it 'reads from the dom', ->
  #     model = _subject.read()

  #     expect(model.name).toBe 'Bob Golly'
  #     expect(model.age).toBe '25'

  #   it 'only reads from inputs', ->
  #     _jq.find('#name').html('Changed')
  #     _jq.find('#age').val('35')
  #     model = _subject.read()

  #     expect(model.name).toBe 'Bob Golly'
  #     expect(model.age).toBe '35'