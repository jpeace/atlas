class BindingExpression
  constructor: (expression) ->
    @parse(expression)

  parse: (expression) =>
    @bindings = []