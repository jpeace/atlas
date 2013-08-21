class BackgroundColor extends atlas.binding.Base
  this.target = ->
    atlas.binding.targets.backgroundColor
  this.sources = ->
    [atlas.binding.sources.presenter, atlas.binding.sources.model]

  setValue: (value) ->
    __$(@element).setStyle({'background-color':value})

  getValue: ->
    __$(@element).getStyle('background-color')