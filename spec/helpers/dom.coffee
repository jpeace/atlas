tests.dom.elementFromString = (html) ->
  # doc = document.implementation.createDocument("http://www.w3.org/1999/xhtml", "html", null )
  # body = doc.createElement('body')
  # div = doc.createElement('div')

  # div.innerHTML = html
  # body.appendChild(div)
  # doc.documentElement.appendChild(body)
  # doc.documentElement.innerHTML = html

  # return doc
  div = window.document.createElement('div')
  div.innerHTML = html
  return div

tests.dom.simpleDocument =  """
                            <div data-presenter="Presenter">
                            </div>
                            """

tests.dom.emptyElement = window.document.createElement('div')