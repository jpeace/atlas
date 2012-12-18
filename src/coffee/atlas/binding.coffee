require 'atlas/binding/binder'
require 'atlas/binding/binding_expression'

require 'atlas/binding/base'
require 'atlas/binding/bindings/display'
require 'atlas/binding/bindings/class'
require 'atlas/binding/bindings/background_color'

atlas.export 'binding',
  # Targets
  display: 'display'
  class: 'class'
  backgroundColor: 'backgroundColor'

  # Sources
  model: 'model'
  presenter: 'presenter'

  # Elements
  editableElements: ['input', 'textarea', 'select']