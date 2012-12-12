require 'lib/underscore'

class Atlas
  helpers : {}
  
  add_helper: (name, fn) ->
    @helpers[name] = fn if _.isFunction(fn)

  export: (namespace, object) ->
    ref = @ensure_namespace(namespace)
    ref[key] = value for key, value of object

  ensure_namespace: (namespace) ->
    current_ref = this
    for part in namespace.split('.')
      current_ref[part] = {} unless current_ref[part]?
      current_ref = current_ref[part]
    return current_ref
  
_a = new Atlas();
(exports ? this).atlas = _a
(exports ? this).__ = _a.helpers