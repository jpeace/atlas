class BindingExpression
  require 'core/binding/binding'

  constructor: (expression) ->
    @parse(expression)

  parse: (expression) ->
    @bindings = []
    for expr in expression.split(';')
      [targetExpr,sourceExpr] = (s.trim() for s in expr.split(':'))
      unless sourceExpr?
        sourceExpr = targetExpr
        targetExpr = 'display'

      binding = new titan.core.binding.Binding()
      binding.target = @targetFromExpression(targetExpr)
      binding.sources = @sourcesForTarget(binding.target)

      @bindings.push(binding)

  targetFromExpression: (expr) ->
    switch expr
      when 'display' then titan.core.binding.display
      when 'class' then titan.core.binding.class
      when 'background-color' then titan.core.binding.backgroundColor
      else throw new Error("Did not recognize target #{expr}")

  sourcesForTarget: (target) ->
    switch target
      when titan.core.binding.display then [titan.core.binding.model, titan.core.binding.presenter]
      else [titan.core.binding.presenter, titan.core.binding.model]

# class DisplayAttributeDescriptor
#   attribute: ->
#     titan.core.binding.display
#   targets: ->
#     [titan.core.binding.model, titan.core.binding.presenter]
#   parseTargetExpression: (expr) ->