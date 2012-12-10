class BindingExpression
  
  constructor: (expression) ->
    @parse(expression)

  parse: (expression) ->
    @bindings = []
    for expr in expression.split(';')
      [targetExpr,sourceExpr] = (s.trim() for s in expr.split(':'))
      unless sourceExpr?
        sourceExpr = targetExpr
        targetExpr = 'display'

      target = @targetFromExpression(targetExpr)
      for b in titan.core.binding.bindings
        if b.target() is target
          binding = new b(sourceExpr)
          break

      if binding?
        @bindings.push(binding)
      else
        throw new Error("Did not find binding for target #{target}")

  targetFromExpression: (targetExpression) ->
    switch targetExpression
      when 'display' then titan.core.binding.display
      when 'class' then titan.core.binding.class
      when 'background-color' then titan.core.binding.backgroundColor
      else throw new Error("Did not recognize target #{targetExpression}")