require 'atlas/binding'

efs = tests.dom.elementFromString

templateHtml = 	"""
								<li>
									<span data-bind="name"></span>
								</li>
								"""

createBinding = ->
	binding = new atlas.binding.bindings.Collection()
	binding.root = efs('<ul></ul>').childNodes[0]
	binding.template = templateHtml
	binding.mode = atlas.binding.modes.collection
	binding

createData = ->
	[
		{name:'Dick'},
		{name:'Jane'}
	]

createContext = ->
	model: {}
	presenter: {}

describe 'Collection binding', ->
	describe 'when setting values', ->
		it 'correctly populates the collection', ->
			binding = createBinding()
			binding.setValue(createData(), createContext())
			html = binding.root.innerHTML.stripWhitespace()
			expect(html).toBe('<li><span data-bind="name">Dick</span></li><li><span data-bind="name">Jane</span></li>')

		it 'correctly empties the collection when an empty array is used', ->
			binding = createBinding()
			binding.setValue(createData(), createContext())
			expect(binding.root.innerHTML).not.toBe('')
			binding.setValue([])
			expect(binding.root.innerHTML).toBe('')
			
	describe 'when getting values', ->
		it 'correctly reads the collections', ->
			binding = createBinding()
			binding.setValue(createData(), createContext())
			__$(binding.root).elementsWithAttribute('data-bind')[0].innerHTML = 'Jack'
			data = binding.getValue(createContext())
			expect(data.length).toBe(2)
			expect(data[0].name).toBe('Jack')