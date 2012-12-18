document = window.document

tests.dom.elementFromString = (html) ->
  div = document.createElement('div')
  div.innerHTML = html
  return div

tests.dom.createEvent = (type) ->
  mouseEvents = ['click', 'mousedown', 'mouseup', 'mouseover', 'mousemove', 'mouseout']
  
  if _.contains(mouseEvents, type)
    e = document.createEvent('MouseEvents')
    e.initMouseEvent(type, true, true, window, 
      0, 0, 0, 0, 0, false, false, false, false, 0, null)
  else
    e = document.createEvent('HTMLEvents')
    e.initEvent(type, true, true)
  return e



tests.dom.simpleDocument =  """
                            <div data-presenter="One">
                            </div>
                            <div data-presenter="Two">
                            </div>
                            """

tests.dom.simpleView =  """
                          <div data-bind="name"></div>
                          <div data-bind="age;background-color:ageColor"></div>
                        """

tests.dom.nestedView =  """
                          <div data-bind="user">
                            <div data-bind="contact">
                              <div data-bind="city"></div>
                            </div>
                          </div>
                        """

tests.dom.namespacedDocument = """<div data-presenter="One"></div><div data-presenter="ns.Two"></div>"""

tests.dom.emptyElement = document.createElement('div')