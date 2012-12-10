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

  # Bindings
  bindings: [
    titan.core.binding.bindings.Display, 
    titan.core.binding.bindings.Class,
    titan.core.binding.bindings.BackgroundColor
    ]

titan.export('core.binding', binding)