require 'atlas/binding/binding_expression'

require 'atlas/binding/base'
require 'atlas/binding/bindings/display'
require 'atlas/binding/bindings/class'
require 'atlas/binding/bindings/background_color'
require 'atlas/binding/bindings/collection'
require 'atlas/binding/formatters/base'
require 'atlas/binding/formatters/number'

atlas.export 'binding',
	modes:
    simple: 'simple'
    collection: 'collection'

  targets:
    display: 'display'
    class: 'class'
    backgroundColor: 'backgroundColor'

  sources:
    model: 'model'
    presenter: 'presenter'

  editableElements: ['input', 'textarea', 'select']