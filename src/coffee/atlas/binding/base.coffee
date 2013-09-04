class Base
  this.target = ->
    null
  this.sources = ->
    []
  setValue: (value) ->
  getValue: ->

  constructor: (sourceExpression, context) ->
    context ?= {}

    @element = null
    @mode = atlas.binding.modes.simple
    @target = this.constructor.target()
    @sources = this.constructor.sources()
    @baseProperty = ''
    @properties = []
    @possibleValues = null
    
    @modelPath = context.modelPath ? ''
    
    @parseSourceExpression(sourceExpression)
    
  isDisplay: ->
    @target is atlas.binding.targets.display

  isCollection: ->
    @mode is atlas.binding.modes.collection

  modelProperty: (name) ->
    name ?= @baseProperty
    if @modelPath is '' then name else "#{@modelPath}.#{name}"

  parseSourceExpression: (sourceExpression) ->
    matches = /^([\w\.]+)(\|(\w+))?(\((not )?(\w+)\))?( as (\w+))?$/.exec(sourceExpression)
    throw new Error("Could not parse source expression #{sourceExpression}") unless matches?
  
    # $1 - source property name/true value
    # $2 - has explicit values?
    # $3 - false value
    # $4 - has explicit source property?
    # $5 - explicit source negation
    # $6 - explicit source property name
    # $7 - specifies mode?
    # $8 - mode
    
    trueValue = matches[1]
    falseValue = matches[3] ? ''
    @possibleValues = {true: trueValue, false: falseValue} if (matches[2]? || matches[4]?)

    if matches[7]?
      mode = matches[8]
      throw new Error("Binding mode #{mode} not recognized") unless atlas.binding.modes[mode]?
      @mode = atlas.binding.modes[mode]

    if matches[4]?
      @properties = [matches[6]]
      if matches[5]?
        @possibleValues = {true: falseValue, false: trueValue}
    else
      @properties = [matches[1]]

    @baseProperty = @properties[0]