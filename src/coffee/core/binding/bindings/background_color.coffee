class BackgroundColor extends atlas.core.binding.bindings.Base
  this.target = ->
    atlas.core.binding.backgroundColor
  this.sources = ->
    [atlas.core.binding.presenter, atlas.core.binding.model]