class Binding
  target: null
  sources: []
  properties: []
  possibleValues: []
  
bindingConstants =
  # Targets
  display: 'display'
  class: 'class'
  backgroundColor: 'backgroundColor'

  # Sources
  model: 'model'
  presenter: 'presenter'

titan.export('core.binding', bindingConstants)