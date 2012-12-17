describe 'View', ->
  beforeEach ->
  afterEach ->

  this.in_spec = ->
    34

  it 'does something', =>
    expect(this.in_spec()).toBe(34)

  it 'can spy', =>
    spyOn(this, 'in_spec').andReturn(35)
    expect(this.in_spec()).toBe(35)

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