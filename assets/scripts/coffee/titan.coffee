require 'lib/underscore'

class Titan
  helpers : {}
  
  add_helper: (name, fn) ->
    @helpers[name] = fn if _.isFunction(fn)

  export: (namespace, object) ->
    ref = @ensure_namespace(namespace)
    ref[key] = value for key, value of object

  ensure_namespace: (namespace) ->
    current_ref = this
    namespace.split('.').forEach (part) ->
      current_ref[part] = {} unless current_ref[part]?
      current_ref = current_ref[part]
    return current_ref
  
_t = new Titan();
(exports ? this).titan = _t
(exports ? this).__ = _t.helpers