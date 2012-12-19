class ElementWrapper
  Search = require 'atlas/dom/search'

  constructor: (@element) ->
    _.extend(@, new Search(@element))

  getStyle: (property) ->
    @element.style[property]

  setStyle: (obj) ->
    for key, val of obj
      @element.style[key] = val

  addClass: (className) ->
    add = true
    for c in @getClasses()
      if c is className
        add = false
        break
    original = if @element.className is '' then '' else "#{@element.className} "
    @element.className = "#{original}#{className}" if add

  removeClass: (className) ->
    classes = []
    for c in @getClasses()
      classes.push(c) unless c is className
    @element.className = classes.join(' ')

  hasClass: (className) ->
    _.contains(@getClasses(), className)

  getClasses: ->
    @element.className.split(' ')

return ElementWrapper