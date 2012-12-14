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
                            <h1 data-attr=""></h1>
                            <p data-attr=""></p>
                          </p>
                          """

getSearch = (html) ->
  new Search(tests.dom.elementFromString(html))

describe 'DOM Search', ->
  it 'can find elements by attribute', ->
    elements = getSearch(documentWithAttributes).elementsWithAttribute('data-attr')
    expect(elements.length).toBe(5)