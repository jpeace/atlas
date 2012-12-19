class Class extends atlas.binding.Base
  this.target = ->
    atlas.binding.class
  this.sources = ->
    [atlas.binding.presenter, atlas.binding.model]

  parseSourceExpression: (sourceExpression) ->
    super(sourceExpression)
    baseProperty = @properties[0]
    @properties = [
      "is#{baseProperty.capitalize()}", 
      "should#{baseProperty.capitalize()}",
      baseProperty
      ]

  setValue: (value, options) ->
    options ?= {}
    className = options.className ? ''

    if value is ''
      __$(@element).removeClass(className)
    else
      __$(@element).addClass(value)

  getValue: (options) ->
    options ?= {}
    className = options.className ? ''

    if __$(@element).hasClass(className) then className else ''    