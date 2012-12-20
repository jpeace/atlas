require 'atlas/binding'
Binder = require 'atlas/binding/binder'

efs = tests.dom.elementFromString

describe 'Binder', ->
  describe 'when binding', ->
    it 'performs simple bindings', ->
      b = new tests.bindings.simpleBinding()
      p = new atlas.presenters.One()
      el = efs('<div></div>').childNodes[0]

      spyOn(b, 'setValue')
      Binder.bind(el, b, p.bindingContext())

      expect(b.setValue).toHaveBeenCalledWith(5)

    it 'searches the sources for properties', ->
      b = new tests.bindings.simpleBinding()
      p = new atlas.presenters.Two()
      el = efs('<div></div>').childNodes[0]
      
      spyOn(b, 'setValue')
      Binder.bind(el, b, p.bindingContext())

      expect(b.setValue).toHaveBeenCalledWith(5)

    it 'works with model paths', ->
      b = new tests.bindings.userBinding()
      p = new atlas.presenters.Two()
      el = efs('<div></div>').childNodes[0]
      
      spyOn(b, 'setValue')
      Binder.bind(el, b, p.bindingContext())

      expect(b.setValue).toHaveBeenCalledWith('Bob Golly')      

  describe 'when reading', ->
  