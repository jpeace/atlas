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
      for name, binding of atlas.core.binding.bindings
        continue if name is 'Base'
        if binding.target() is target
          foundBinding = new binding(sourceExpr)
          break

      if foundBinding?
        @bindings.push(foundBinding)
      else
        throw new Error("Did not find binding for target #{target}")

  targetFromExpression: (targetExpression) ->
    switch targetExpression
      when 'display' then atlas.core.binding.display
      when 'class' then atlas.core.binding.class
      when 'background-color' then atlas.core.binding.backgroundColor
      else throw new Error("Did not recognize target #{targetExpression}")