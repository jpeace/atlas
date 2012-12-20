atlas.binding.null = null

class BaseTestBinding
  setValue: (value, options) ->
  getValue: (options) ->

tests.bindings.simpleBinding = 
  class SimpleBinding extends BaseTestBinding
    constructor: (@element) ->
      @target = atlas.binding.null
      @sources = [atlas.binding.presenter, atlas.binding.model]
      @baseProperty = 'value'
      @properties = ['value']
      @possibleValues = null
      @modelPath = ''
    
tests.bindings.userBinding = 
  class UserBinding extends BaseTestBinding
    constructor: (@element) ->
      @target = atlas.binding.null
      @sources = [atlas.binding.presenter, atlas.binding.model]
      @baseProperty = 'name'
      @properties = ['name']
      @possibleValues = null
      @modelPath = 'user'

tests.bindings.complexBinding = 
  class ComplexBinding extends BaseTestBinding
    constructor: (@element) ->
      @target = atlas.binding.null
      @sources = [atlas.binding.presenter, atlas.binding.model]
      @baseProperty = 'value'
      @properties = ['isValue', 'value']
      @possibleValues = {true: 'yes', false: 'no'}
      @modelPath = ''