class Class extends titan.core.binding.bindings.Base
  this.target = ->
    titan.core.binding.class
  this.sources = ->
    [titan.core.binding.presenter, titan.core.binding.model]
  
  parseSourceExpression: (expr) ->