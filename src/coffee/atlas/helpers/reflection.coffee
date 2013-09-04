atlas.addHelper 'getProperty', (obj, prop, options) ->  
  options ?= {}
  followFunctions = options.followFunctions ? true

  current = obj
  for name in prop.split('.')
    return null unless current?
    current = 
      if _.isFunction(current[name]) and followFunctions
        current[name]() 
      else 
        current[name]
  return current ? null

atlas.addHelper 'setProperty', (obj, prop, value) ->
  current = obj
  names = prop.split('.')
  for i in [0...(names.length-1)]
    verifyPropertyWrite(current, prop)
    current = current[names[i]]
    
  verifyPropertyWrite(current[names.last()], prop)
  current[names.last()] = value

verifyPropertyWrite = (property, name) ->
  throw new Error("Property does not exist #{name}") unless property?
  throw new Error("Property refers to a function #{name}") if _.isFunction(property)