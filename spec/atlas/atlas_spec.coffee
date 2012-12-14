describe 'Global Atlas object', ->
  it 'is made available through the atlas symbol', ->
    expect(atlas).not.toBe(null)

  it 'exports a double underscore to access helpers', ->
    expect(__).not.toBe(null)

  it 'supports registration of new helper methods', ->
    atlas.add_helper 'myHelper', ->
      'I helped!'
    expect(__.myHelper()).toBe('I helped!')

  describe 'when exporting symbols', ->
    it 'can export symbols with a simple namespace', ->
      atlas.export 'namespace',
        name:'value'
      expect(atlas.namespace.name).toBe('value')

    it 'can export symbols with a complex namespace', ->
      atlas.export 'a.complex.namespace',
        name:'value'
      expect(atlas.a.complex.namespace.name).toBe('value')

    it 'can export objects', ->
      atlas.export 'some.path',
        foo:'bar' 
        eeny:'meeny'
      expect(atlas.some.path.foo).toBe('bar')
      expect(atlas.some.path.eeny).toBe('meeny')