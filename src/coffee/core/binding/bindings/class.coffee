class Class extends atlas.core.binding.bindings.Base
  this.target = ->
    atlas.core.binding.class
  this.sources = ->
    [atlas.core.binding.presenter, atlas.core.binding.model]

  parseSourceExpression: (sourceExpression) ->
    super(sourceExpression)
    baseProperty = @properties[0]
    @properties = [
      "is#{baseProperty.capitalize()}", 
      "should#{baseProperty.capitalize()}",
      baseProperty
      ]