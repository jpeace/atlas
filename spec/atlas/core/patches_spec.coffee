describe 'String patches', ->
  it 'can capitalize strings', ->
    expect('lowercase'.capitalize()).toBe('Lowercase')

describe 'Array patches', ->
  it 'can give the last element of an array', ->
    expect([].last()).toBeNull()
    expect([1,2,3].last()).toBe(3)