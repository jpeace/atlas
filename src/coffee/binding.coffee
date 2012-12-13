require 'binding/binder'
require 'binding/binding_expression'

require 'binding/bindings/base'
require 'binding/bindings/display'
require 'binding/bindings/class'
require 'binding/bindings/background_color'

binding =
  # Targets
  display: 'display'
  class: 'class'
  backgroundColor: 'backgroundColor'

  # Sources
  model: 'model'
  presenter: 'presenter'

atlas.export('binding', binding)