require 'atlas/dom'

html =  """
        <h1>Title</h1>
        <div id="someDiv">
          <ul class="list">
            <li>Item 1</li>
            <li>Item 2</li>
          </ul>
        </div>
        """

getBuilder = ->
  new atlas.dom.Builder(window.document)

describe 'DOM Builder', ->
  it 'can build elements from HTML strings', ->
    element = getBuilder().createElement(html)
    # Newlines create text nodes... hence the extra children
    expect(element.childNodes.length).toBe(3)
    expect(element.childNodes[2].childNodes.length).toBe(3)
    expect(element.childNodes[2].childNodes[1].childNodes.length).toBe(5)