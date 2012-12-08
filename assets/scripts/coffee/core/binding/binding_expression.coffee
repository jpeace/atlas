class BindingExpression
  require 'core/binding/binding'

  constructor: (expression) ->
    @parse(expression)

  parse: (expression) ->
    @bindings = []
    for expr in expression.split(';')
      [bound,target] = (s.trim() for s in expr.split(':'))
      unless target?
        target = bound
        bound = 'display'

      binding = new titan.core.binding.Binding()
      binding.boundAttribute = @boundAttributeFromString(bound)
      binding.targets = @targetsForBoundAttribute(binding.boundAttribute)

      @bindings.push(binding)

  boundAttributeFromString: (str) ->
    switch str
      when 'display' then titan.core.binding.display
      when 'class' then titan.core.binding.class
      when 'background-color' then titan.core.binding.backgroundColor
      else throw new Error("Did not recognize bound attribute #{str}")

  targetsForBoundAttribute: (boundAttribute) ->
    switch boundAttribute
      when titan.core.binding.display then [titan.core.binding.model, titan.core.binding.presenter]
      else [titan.core.binding.presenter, titan.core.binding.model]