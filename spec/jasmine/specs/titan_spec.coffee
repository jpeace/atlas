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

  describe 'when exporting symbols', ->
    it 'can export symbols with a simple namespace', ->
      titan.export('namespace', {name:'value'})
      expect(titan.namespace.name).toBe('value')

    it 'can export symbols with a complex namespace', ->
      titan.export('a.complex.namespace', {name:'value'})
      expect(titan.a.complex.namespace.name).toBe('value')

    it 'can export objects', ->
      titan.export('some.path', {foo:'bar', eeny:'meeny'})
      expect(titan.some.path.foo).toBe('bar')
      expect(titan.some.path.eeny).toBe('meeny')