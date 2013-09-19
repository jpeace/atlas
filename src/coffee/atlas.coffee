require 'lib/underscore'

class Atlas
  helpers: {}
  behaviors: {}
  formatters: {}
  presenters: {}
  settings: {}
  
  addHelper: (name, fn) ->
    @helpers[name] = fn if _.isFunction(fn)

  addBehavior: (namespace, name, ctor) ->
    @behaviors[namespace] ?= {}
    @behaviors[namespace][name] = ctor if _.isFunction(ctor)

  addFormatter: (name, ctor) ->
    @formatters[name] = ctor if _.isFunction(ctor)
    
  export: (namespace, object) ->
    ref = @ensureNamespace(namespace)
    ref[key] = value for key, value of object

  ensureNamespace: (namespace) ->
    current_ref = this
    for part in namespace.split('.')
      current_ref[part] = {} unless current_ref[part]?
      current_ref = current_ref[part]
    return current_ref
  
_a = new Atlas();
(exports ? this).atlas = _a
(exports ? this).__ = _a.helpers