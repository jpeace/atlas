class Builder
  constructor: (@document) ->

  createElement: (html) ->
    div = @document.createElement('div')
    div.innerHTML = html
    return div

return Builder