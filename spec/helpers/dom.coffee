document = window.document

tests.dom.elementFromString = (html) ->
  div = document.createElement('div')
  div.innerHTML = html
  return div

tests.dom.simpleDocument =  """
                            <div data-presenter="One">
                            </div>
                            <div data-presenter="Two">
                            </div>
                            """

tests.dom.namespacedDocument = """<div data-presenter="One"></div><div data-presenter="ns.Two"></div>"""

tests.dom.emptyElement = document.createElement('div')