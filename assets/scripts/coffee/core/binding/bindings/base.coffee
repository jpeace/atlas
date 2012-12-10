class Base
  properties: []
  possibleValues: []

  constructor: (sourceExpression) ->
    @target = this.constructor.target()
    @sources = this.constructor.sources()
    @parseSourceExpression(sourceExpression)