class Base
  this.target = ->
    null
  this.sources = ->
    []
  setValue: (value) ->
  getValue: ->

  constructor: (sourceExpression, context) ->
    context ?= {}

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

  resolveAccessor: (context)->
    for source in @sources
      for propertyName in @properties
        sourceObj = __.getProperty(context, source)
        throw new Error("Invalid source: #{source}") unless sourceObj?

        propertyPath = 
          if source is atlas.binding.sources.model
            @modelProperty(propertyName) 
          else 
            propertyName

        val = __.getProperty(sourceObj, propertyPath, {arg:@propertyArg})
        if val?
          return {
            source: sourceObj,
            path: propertyPath,
            currentValue: val
          }
    throw new Error("Could not resolve accessor")

  parseSourceExpression: (sourceExpression) ->
    matches = /^([\w\.]+)(\|(\w+))?(\((not )?(\w+)(\((\w+)\))?\))?( as (\w+))?$/.exec(sourceExpression)
    throw new Error("Could not parse source expression #{sourceExpression}") unless matches?
  
    # $1 - source property name/true value
    # $2 - has explicit values?
    # $3 - false value
    # $4 - has explicit source property?
    # $5 - explicit source negation
    # $6 - explicit source property name
    # $7 - has property argument?
    # $8 - property argument name
    # $9 - specifies mode?
    # $10 - mode
    
    trueValue = matches[1]
    falseValue = matches[3] ? ''
    @possibleValues = {true: trueValue, false: falseValue} if (matches[2]? || matches[4]?)

    if matches[9]?
      mode = matches[10]
      throw new Error("Binding mode #{mode} not recognized") unless atlas.binding.modes[mode]?
      @mode = atlas.binding.modes[mode]

    if matches[4]?
      @properties = [matches[6]]
      if matches[5]?
        @possibleValues = {true: falseValue, false: trueValue}
      if matches[7]?
        @propertyArg = matches[8]
    else
      @properties = [matches[1]]

    @baseProperty = @properties[0]