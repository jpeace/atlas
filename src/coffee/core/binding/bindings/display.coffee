class Display extends atlas.core.binding.bindings.Base
  this.target = ->
    atlas.core.binding.display
  this.sources = ->
    [atlas.core.binding.model, atlas.core.binding.presenter]