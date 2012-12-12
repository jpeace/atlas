class BackgroundColor extends titan.core.binding.bindings.Base
  this.target = ->
    titan.core.binding.backgroundColor
  this.sources = ->
    [titan.core.binding.presenter, titan.core.binding.model]