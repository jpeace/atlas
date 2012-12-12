require 'core/binding/binder'
require 'core/binding/binding_expression'

require 'core/binding/bindings/base'
require 'core/binding/bindings/display'
require 'core/binding/bindings/class'
require 'core/binding/bindings/background_color'

binding =
  # Targets
  display: 'display'
  class: 'class'
  backgroundColor: 'backgroundColor'

  # Sources
  model: 'model'
  presenter: 'presenter'

atlas.export('core.binding', binding)