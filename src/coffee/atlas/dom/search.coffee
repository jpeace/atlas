class Search
  constructor: (@element)->

  elementsWithAttribute: (attribute)->
    if @element.querySelectorAll?
      @element.querySelectorAll("[#{attribute}]")
    else
      # Slower fallback for older browsers
      matchingElements = []
      allElements = @element.getElementsByTagName('*')
      for el in allElements
        if el.getAttribute(attribute)?
          matchingElements.push(el)
      return matchingElements