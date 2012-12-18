class Display extends atlas.binding.Base
  this.target = ->
    atlas.binding.display
  this.sources = ->
    [atlas.binding.model, atlas.binding.presenter]

  setValue: (value) ->
    @element[@displayProperty()] = value

  getValue: ->
    @element[@displayProperty()]

  displayProperty: ->
    if _.contains(atlas.binding.editableElements, @element.tagName.toLowerCase())
      'value'
    else
      if @element.textContent?
        'textContent'
      else if @element.innerText?
        'innerText'