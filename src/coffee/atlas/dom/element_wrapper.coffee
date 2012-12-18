class ElementWrapper
  Search = require 'atlas/dom/search'

  constructor: (@element) ->
    _.extend(@, new Search(@element))

  getStyle: (property) ->
    @element.style[property]

  setStyle: (obj) ->
    for key, val of obj
      @element.style[key] = val

return ElementWrapper