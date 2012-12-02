class Titan
  constructor: ->
    @core = {}
    @presenters = {}
    @helpers = {}
    
  add_helper: (name, fn) =>
    @helpers[name] = fn if _.isFunction(fn)

_t = new Titan();
window.titan = _t
window.__ = _t.helpers