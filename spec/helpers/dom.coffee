document = window.document

tests.dom.elementFromString = (html) ->
  div = document.createElement('div')
  div.innerHTML = html
  return div

tests.dom.simpleDocument =  """
                            <div data-presenter="PresenterOne">
                            </div>
                            <div data-presenter="ns.PresenterTwo">
                            </div>
                            """

tests.dom.emptyElement = document.createElement('div')