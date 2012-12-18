class View
  require 'atlas/binding'

  constructor: (@element) ->
    @bindings = @buildBindings(@element, '')

  buildBindings: (node, modelPath) ->
    bindings = []
    for child in node.childNodes
      continue unless child.hasAttribute?
      if child.hasAttribute('data-bind')
        expression = child.getAttribute('data-bind')
        context =
          modelPath: modelPath

        outerBindings = new atlas.binding.BindingExpression(expression, context).bindings
        displayBinding = _.find(outerBindings, (b) -> b.target is atlas.binding.display)
        
        innerModelPath = 
          if displayBinding?
            if modelPath is '' then displayBinding.properties[0] else "#{modelPath}.#{displayBinding.properties[0]}"
          else
            modelPath
        innerBindings = @buildBindings(child, innerModelPath)
        removeDisplayBinding = innerBindings.length > 0

        for binding in outerBindings
          binding.element = child
          bindings.push(binding) unless binding.target is atlas.binding.display and removeDisplayBinding
        for binding in innerBindings
          bindings.push(binding)
        
    return bindings












  # bind: (model) ->
    # @model = model
    # for own prop, val of @model
    #   $(@element).find("[data-property=#{prop}]").each ->
    #     if this.tagName.toLowerCase() == 'div'
    #       this.innerHTML = val
    #     else
    #       this.value = val

  # read: ->
    # @model ?= {}
    # $(@element).find('input, div').each (i, el) =>
    #   prop_name = $(el).attr('data-property')
    #   return unless prop_name?
      
    #   if el.tagName.toLowerCase() == 'div'
    #     @model[prop_name] = el.innerHTML unless @model[prop_name]?
    #   else
    #     @model[prop_name] = el.value
    # return @model