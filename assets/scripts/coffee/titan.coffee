class Titan
  constructor: ->
    @classes = {}
    @helpers = {}
    @presenters = {}

  define: (fn) ->
    @classes[fn.name] = fn if _.isFunction(fn)

  presenter: (fn) =>
    @presenters[fn.name.replace('Presenter','')] = fn if _.isFunction(fn)

  add_helper: (name, fn) =>
    @helpers[name] = fn if _.isFunction(fn)

_t = new Titan();
window.titan = _t
window.__ = _t.helpers