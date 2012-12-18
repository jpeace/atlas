class BackgroundColor extends atlas.binding.Base
  this.target = ->
    atlas.binding.backgroundColor
  this.sources = ->
    [atlas.binding.presenter, atlas.binding.model]