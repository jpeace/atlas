class Class extends atlas.binding.bindings.Base
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