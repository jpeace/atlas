class Display extends titan.core.binding.bindings.Base
  this.target = ->
    titan.core.binding.display
  this.sources = ->
    [titan.core.binding.model, titan.core.binding.presenter]

  parseSourceExpression: (expr) ->