class Display extends atlas.binding.bindings.Base
  this.target = ->
    atlas.binding.display
  this.sources = ->
    [atlas.binding.model, atlas.binding.presenter]