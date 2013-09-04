class View
  require 'atlas/binding'

  constructor: (@root) ->
    @bindings = @buildBindings(@root, '')

  buildBindings: (node, modelPath) ->
    bindings = []
    for child in node.childNodes
      continue unless child.hasAttribute?
      if child.hasAttribute('data-bind')
        expression = child.getAttribute('data-bind')
        context =
          modelPath: modelPath

        outerBindings = new atlas.binding.BindingExpression(expression, context).bindings
        displayBinding = _.find(outerBindings, (b) -> b.isDisplay())
        removeDisplayBinding = false

        if child.hasAttribute('data-format') and displayBinding?
          displayBinding.format = @parseFormatString(child.getAttribute('data-format'))

        innerModelPath = 
          if displayBinding?
            if modelPath is '' then displayBinding.properties[0] else "#{modelPath}.#{displayBinding.properties[0]}"
          else
            modelPath
          
        if displayBinding?.isCollection()
          collectionBinding = new atlas.binding.bindings.Collection().convertDisplayBinding(displayBinding, child)
          bindings.push(collectionBinding)
          
          removeDisplayBinding = true
        else
          innerBindings = @buildBindings(child, innerModelPath)
          bindings.push(binding) for binding in innerBindings

          removeDisplayBinding = innerBindings.length > 0

        for binding in outerBindings
            binding.element = child
            bindings.push(binding) unless binding.isDisplay() and removeDisplayBinding
    
    return bindings

  parseFormatString: (formatString) ->
    matches = /^(\w+)\.(\w+)(\((.+)\))?$/.exec(formatString)
    throw new Error("Could not parse format string #{formatString}") unless matches?

    formatter = matches[1]
    method = matches[2]
    args = matches[4] ? null

    throw new Error("Could not find formatter #{formatter}") unless _.isFunction(atlas.formatters[formatter])
    source = new atlas.formatters[formatter]()

    throw new Error("Invalid method #{method}") unless _.isFunction(source[method])

    {
      source: source
      method: method
      args: args
    }