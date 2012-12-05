describe 'Global Titan object', ->
  it 'is made available through the titan symbol', ->
    expect(titan).not.toBe(null)

  it 'exports a double underscore to access helpers', ->
    expect(__).not.toBe(null)

  it 'supports registration of new helper methods', ->
    titan.add_helper('myHelper', ->
      'I helped!'
    )
    expect(__.myHelper()).toBe('I helped!')

  describe 'when adding constants', ->
    it 'can add constants with a simple namespace', ->
      titan.add_constant('namespace', {name:'value'})
      expect(titan.namespace.name).toBe('value')

    it 'can add constants with a complex namespace', ->
      titan.add_constant('a.complex.namespace', {name:'value'})
      expect(titan.a.complex.namespace.name).toBe('value')

    it 'can add object constants', ->
      titan.add_constant('some.path', {foo:'bar', eeny:'meeny'})
      expect(titan.some.path.foo).toBe('bar')
      expect(titan.some.path.eeny).toBe('meeny')