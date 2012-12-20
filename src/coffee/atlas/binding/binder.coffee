class Binder
  this.bind = (binding, context) ->
    found = false
    value = null
    for source in binding.sources
      for propertyName in binding.properties
        sourceObj = __.getProperty(context, source)
        throw new Error("Invalid source: #{source}") unless sourceObj?

        propertyPath = 
          if source is atlas.binding.model
            binding.modelProperty(propertyName) 
          else 
            propertyName

        value = __.getProperty(sourceObj, propertyPath)
        if value?
          if binding.possibleValues?
            value = binding.possibleValues[value]
          found = true
          break
      break if found

    binding.setValue(value)

  this.read = (binding, context) ->
    __.setProperty(context.presenter.model(), binding.modelProperty(), binding.getValue())

return Binder