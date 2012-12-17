atlas.add_helper 'getProperty', (obj, prop) ->  
  current = obj
  for name in prop.split('.')
    return null unless current?
    current = current[name]
  return current

atlas.add_helper 'setProperty', (obj, prop, value) ->
  current = obj
  names = prop.split('.')
  for i in [0...(names.length-1)]
    throw new Error("Property does not exist #{prop}") unless current?
    current = current[names[i]]
  throw new Error("Property does not exist #{prop}") unless current[names.last()]
  current[names.last()] = value