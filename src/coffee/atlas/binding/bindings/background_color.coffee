class BackgroundColor extends atlas.binding.Base
  this.target = ->
    atlas.binding.backgroundColor
  this.sources = ->
    [atlas.binding.presenter, atlas.binding.model]

  setValue: (value) ->
    __$(@element).setStyle({'background-color':value})

  getValue: ->
    __$(@element).getStyle('background-color')