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

        # TODO - Look for data-type attribute and transform display binding into list etc. binding

        innerModelPath = 
          if displayBinding?
            if modelPath is '' then displayBinding.properties[0] else "#{modelPath}.#{displayBinding.properties[0]}"
          else
            modelPath
        innerBindings = @buildBindings(child, innerModelPath)
        removeDisplayBinding = innerBindings.length > 0

        for binding in outerBindings
          binding.element = child
          bindings.push(binding) unless binding.isDisplay() and removeDisplayBinding
        bindings.push(binding) for binding in innerBindings
    
    return bindings