class Class extends atlas.binding.Base
  this.target = ->
    atlas.binding.targets.class
  this.sources = ->
    [atlas.binding.sources.presenter, atlas.binding.sources.model]

  parseSourceExpression: (sourceExpression) ->
    super(sourceExpression)
    @properties = [
      "is#{@baseProperty.capitalize()}", 
      "should#{@baseProperty.capitalize()}",
      @baseProperty
      ]

  setValue: (value) ->
    el = __$(@element)
    el.removeClass(v) for k,v of @possibleValues if @possibleValues?
  
    if value is ''
      el.removeClass(@baseProperty)
    else
      el.addClass(value)

  getValue: (options) ->
    if __$(@element).hasClass(@baseProperty) then @baseProperty else ''    