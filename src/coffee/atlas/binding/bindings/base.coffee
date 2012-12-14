class Base
  element: null
  properties: []
  possibleValues: null

  this.target = ->
    null
  this.sources = ->
    []

  constructor: (sourceExpression) ->
    @element = null
    @target = this.constructor.target()
    @sources = this.constructor.sources()
    @parseSourceExpression(sourceExpression)

  parseSourceExpression: (sourceExpression) ->
    matches = /^(\w+)(\|(\w+))?(\((not )?(\w+)\))?$/.exec(sourceExpression)
    throw new Error("Could not parse source expression #{sourceExpression}") unless matches?
  
    # $1 - source property name/true value
    # $2 - has explicit values?
    # $3 - false value
    # $4 - has explicit source property?
    # $5 - explicit source negation
    # $6 - explicit source property name
    
    trueValue = matches[1]
    falseValue = matches[3] ? ''
    @possibleValues = {true: trueValue, false: falseValue} if (matches[2]? || matches[4]?)

    if matches[4]?
      @properties = [matches[6]]
      if matches[5]?
        @possibleValues = {true: falseValue, false: trueValue}
    else
      @properties = [matches[1]]