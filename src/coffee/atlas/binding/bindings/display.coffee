class Display extends atlas.binding.Base
  this.target = ->
    atlas.binding.targets.display
  this.sources = ->
    [atlas.binding.sources.model, atlas.binding.sources.presenter]

  setValue: (value) ->
    if @format?
      value = @format.source[@format.method](value, @format.args) if @format.source.canFormat?(value)
    @element[@displayProperty()] = value if value?

  getValue: ->
    value = @element[@displayProperty()]

  displayProperty: ->
    if _.contains(atlas.binding.editableElements, @element.tagName.toLowerCase())
      'value'
    else
      if @element.textContent?
        'textContent'
      else if @element.innerText?
        'innerText'