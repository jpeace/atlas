class Binding
  boundAttribute: ''
  targets: []
  properties: []
  possibleValues: []
  
bindingConstants =
  # Bound Attributes
  display: 'display',
  class: 'class',
  backgroundColor: 'backgroundColor',

  # Targets
  model: 'model',
  presenter: 'presenter'

titan.export('core.binding', bindingConstants)