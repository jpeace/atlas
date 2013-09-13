class Binder
  this.bind = (binding, context) ->
    try
      value = binding.resolveAccessor(context).currentValue
      if value?
        if binding.possibleValues?
          value = binding.possibleValues[value]
      
      binding.setValue(value, context)
    catch
      binding.setValue(null, context)
    
  this.read = (binding, context) ->
    try
      value = binding.getValue(context)
      if binding.format?.source?.canParse?(value)
        parser = binding.format.source["parse#{binding.format.method.capitalize()}"]
        value = parser.call(binding.format.source, value, binding.format.args) if parser?
      value = parseFloat(value) if /^\d+(\.\d+)?$/.test(value)

      propertyName = binding.modelProperty()
      context.model[propertyName] ?= {}
      __.setProperty(context.model, binding.modelProperty(), value)
    catch error # Tried to set function or property doesn't exist on model - ignore

return Binder