atlas.binding.null = null

class BaseTestBinding extends atlas.binding.Base
  setValue: (value, options) ->
  getValue: (options) ->

tests.bindings.NullBinding = 
  class NullBinding extends BaseTestBinding
    constructor: (@element) ->
      @target = atlas.binding.null
      @sources = [atlas.binding.sources.presenter, atlas.binding.sources.model]
      @baseProperty = 'notHere'
      @properties = ['notHere']
      @possibleValues = null
      @modelPath = ''

tests.bindings.SimpleBinding = 
  class SimpleBinding extends BaseTestBinding
    constructor: (@element) ->
      @target = atlas.binding.null
      @sources = [atlas.binding.sources.presenter, atlas.binding.sources.model]
      @baseProperty = 'value'
      @properties = ['value']
      @possibleValues = null
      @modelPath = ''
    
tests.bindings.ModelPathBinding = 
  class ModelPathBinding extends BaseTestBinding
    constructor: (@element) ->
      @target = atlas.binding.null
      @sources = [atlas.binding.sources.presenter, atlas.binding.sources.model]
      @baseProperty = 'firstName'
      @properties = ['firstName']
      @possibleValues = null
      @modelPath = 'user'

tests.bindings.MultiplePropertiesBinding = 
  class MultiplePropertiesBinding extends BaseTestBinding
    constructor: (@element) ->
      @target = atlas.binding.null
      @sources = [atlas.binding.sources.presenter, atlas.binding.sources.model]
      @baseProperty = 'hidden'
      @properties = ['isHidden', 'hidden']
      @possibleValues = null
      @modelPath = 'user'

tests.bindings.PossibleValuesBinding = 
  class PossibleValuesBinding extends BaseTestBinding
    constructor: (@element) ->
      @target = atlas.binding.null
      @sources = [atlas.binding.sources.presenter, atlas.binding.sources.model]
      @baseProperty = 'admin'
      @properties = ['isAdmin', 'admin']
      @possibleValues = {true: 'editable', false: 'locked'}
      @modelPath = ''