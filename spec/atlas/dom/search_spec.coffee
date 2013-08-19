Search = require 'atlas/dom/search'

documentWithAttributes =  """
                          <div data-attr="value">
                            <ul>
                              <li data-attr="value"></li>
                              <li>
                                <span data-attr="value"></span>
                              </li>
                            </ul>
                          </div>
                          <p>                   
                          </p>
                          <h1 data-attr=""></h1>
                          <p data-attr="value"></p>
                          """

documentWithClassNames =  """
                          <h1 class="myClass"></h1>
                          <div>
                            <span class="different myClass"></span>
                          </div>
                          """


getSearch = (html) ->
  new Search(tests.dom.elementFromString(html))

describe 'DOM Search', ->
  it 'can find elements by attribute', ->
    elements = getSearch(documentWithAttributes).elementsWithAttribute('data-attr')
    expect(elements.length).toBe(5)

  it 'can find elements with class name', ->
    elements = getSearch(documentWithClassNames).elementsWithClass('myClass')
    expect(elements.length).toBe(2)

  it 'can find elements of a given type', ->
    elements = getSearch(documentWithAttributes).elementsOfType('p')
    expect(elements.length).toBe(2)