describe 'Binder', ->
  require 'atlas/binding'
  Binder = require 'atlas/binding/binder'

  efs = tests.dom.elementFromString

  assertBoundValue = (bindingCtor, presenterCtor, value) ->
    b = new bindingCtor()
    p = new presenterCtor()
    
    spyOn(b, 'setValue')
    Binder.bind(b, p.bindingContext())

    expect(b.setValue).toHaveBeenCalledWith(value, jasmine.any(Object))

  assertWrittenProperty = (bindingCtor, presenterCtor, propertyPath) ->
    b = new bindingCtor()
    p = new presenterCtor()
    
    spyOn(b, 'getValue').andReturn('value')
    Binder.read(b, p.bindingContext())

    expect(__.getProperty(p.model(), propertyPath)).toBe('value')

  describe 'when binding', ->
    it 'performs simple bindings', ->
      assertBoundValue(tests.bindings.SimpleBinding, atlas.presenters.One, 5)

    it 'searches the sources for properties', ->
      assertBoundValue(tests.bindings.SimpleBinding, atlas.presenters.Two, 5)
      
    it 'works with model paths', ->
      assertBoundValue(tests.bindings.ModelPathBinding, atlas.presenters.Two, 'Bob')
      
    it 'works with multiple properties', ->
      assertBoundValue(tests.bindings.MultiplePropertiesBinding, atlas.presenters.One, 'yes')
      assertBoundValue(tests.bindings.MultiplePropertiesBinding, atlas.presenters.Two, 'no')

    it 'works with different possible values', ->
      assertBoundValue(tests.bindings.PossibleValuesBinding, atlas.presenters.One, 'locked')
      assertBoundValue(tests.bindings.PossibleValuesBinding, atlas.presenters.Two, 'editable') 

    it 'binds null when no match is found', ->
      assertBoundValue(tests.bindings.NullBinding, atlas.presenters.One, null)

  describe 'when reading', ->
    it 'writes to the correct model property', ->
      assertWrittenProperty(tests.bindings.ModelPathBinding, atlas.presenters.Two, 'user.firstName')

    it 'parses when there is a data formatter', ->
      b = new tests.bindings.ModelPathBinding()
      b.format =
        source: new atlas.formatters.number(),
        method: 'currency'
        args: null
      p = new atlas.presenters.Two()  

      spyOn(b, 'getValue').andReturn('$24.50')
      Binder.read(b, p.bindingContext())
      expect(__.getProperty(p.model(), 'user.firstName')).toBe(24.5)

    it 'parses numbers automatically', ->
      b = new tests.bindings.ModelPathBinding()
      p = new atlas.presenters.Two()
    
      spyOn(b, 'getValue').andReturn('12')
      Binder.read(b, p.bindingContext())
      expect(__.getProperty(p.model(), 'user.firstName')).toBe(12)

    it 'handles strings that contain/start with numbers', ->
      b = new tests.bindings.ModelPathBinding()
      p = new atlas.presenters.Two()

      spyOn(b, 'getValue').andReturn('12 Main St')
      Binder.read(b, p.bindingContext())
      expect(__.getProperty(p.model(), 'user.firstName')).toBe('12 Main St')

    it 'handles read only/non model properties', ->
      expect(-> 
        Binder.read(
          new tests.bindings.MultiplePropertiesBinding(), 
          new atlas.presenters.Two().bindingContext()
        )
      ).not.toThrow()