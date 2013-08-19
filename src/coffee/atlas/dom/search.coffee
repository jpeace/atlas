class Search
  constructor: (@element)->

  matchElements: (fn)->
    # Slower fallback for old browsers
    el for el in @element.getElementsByTagName('*') when fn(el)
    
  elementsWithAttribute: (attribute)->
    if @element.querySelectorAll?
      @element.querySelectorAll("[#{attribute}]")
    else
    @matchElements((el)-> el.getAttribute(attribute)?)

  elementsWithClass: (className)->
    if @element.getElementsByClassName?
      @element.getElementsByClassName(className)
    else if @element.querySelectorAll?
      @element.querySelectorAll(".#{className}")
    else
      @matchElements((el)-> if el.className? then _.contains(el.className.split(' '), className) else false)

  elementsOfType: (tagName)->
    @element.getElementsByTagName(tagName)

return Search