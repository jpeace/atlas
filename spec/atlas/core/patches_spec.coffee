describe 'String patches', ->
  it 'can capitalize strings', ->
    expect('lowercase'.capitalize()).toBe('Lowercase')

  it 'can display a number with commas', ->
  	expect('512342.434'.numberWithCommas()).toBe('512,342.434')

describe 'Array patches', ->
  it 'can give the last element of an array', ->
    expect([].last()).toBeNull()
    expect([1,2,3].last()).toBe(3)