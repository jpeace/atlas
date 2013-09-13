require 'atlas/binding'

efs = tests.dom.elementFromString

simpleTemplate = 	"""
									<li>
										<span data-bind="name"></span>
									</li>
									"""

implicitTemplateHtml = 	"""
												<ul data-bind="people as collection">
													<li>
														<span data-bind="name"></span>
														<button data-name="edit">Edit</button>
													</li>
												</ul>
												"""

explicitTemplateHtml 	= """
												<div data-bind="people as collection" data-template="person">
													<h1>Header</h1>
													<div data-template-name="person">
														<span data-bind="name"></span>
													</div>
													<span>Footer</span>
												</div>
												"""

createBinding = ->
	binding = new atlas.binding.bindings.Collection()
	binding.sources = [atlas.binding.sources.model]
	binding.properties = ['data']
	binding.root = efs('<ul></ul>').childNodes[0]
	binding.template = simpleTemplate
	binding.mode = atlas.binding.modes.collection
	binding

createData = ->
	[
		{name:'Dick'},
		{name:'Jane'}
	]

createContext = ->
	model: 
		data: createData()
	presenter: 
		bootstrapper: 
			hookEvents: ->
		editClicked: =>

convertDisplayBinding = (html) ->
	base = new atlas.binding.bindings.Display('people as collection', {})
	base.sources = [atlas.binding.sources.model]
	base.properties = ['data']
	root = efs(html).childNodes[0]
	[root, new atlas.binding.bindings.Collection().convertDisplayBinding(base, root)]

describe 'Collection binding', ->
	describe 'when converting from a display binding', ->
		it 'builds the correct template', ->
			[element, binding] = convertDisplayBinding(implicitTemplateHtml)
			html = binding.template.stripWhitespace()
			expect(html).toBe('<li><span data-bind="name"></span><button data-name="edit">Edit</button></li>')
			
		it 'supports explicit templates', ->
			[element, binding] = convertDisplayBinding(explicitTemplateHtml)
			
			templateHtml = binding.template.stripWhitespace()
			expect(templateHtml).toBe('<div data-template-name="person"><span data-bind="name"></span></div>')
			
			binding.setValue([], createContext())
			containerHtml = binding.containerNode.outerHTML.stripWhitespace()
			expected = 	'<div data-bind="people as collection" data-template="person">' +
										'<h1>Header</h1>' +
										'<div data-placeholder="collection"></div>' +
										'<span>Footer</span>' + 
									'</div>'
			expect(containerHtml).toBe(expected)
			
			binding.setValue(createData(), createContext())
			containerHtml = binding.containerNode.outerHTML.stripWhitespace()
			expected = 	'<div data-bind="people as collection" data-template="person">' +
										'<h1>Header</h1>' +
										'<div data-template-name="person" data-collection-item="1"><span data-bind="name">Dick</span></div>' +
										'<div data-template-name="person" data-collection-item="2"><span data-bind="name">Jane</span></div>' +
										'<span>Footer</span>' + 
									'</div>'
			expect(containerHtml).toBe(expected)
			
	describe 'when setting values', ->
		it 'correctly populates the collection', ->
			binding = createBinding()
			binding.setValue(createData(), createContext())
			html = binding.root.innerHTML.stripWhitespace()
			expected = 	'<li data-collection-item="1"><span data-bind="name">Dick</span></li>' +
									'<li data-collection-item="2"><span data-bind="name">Jane</span></li>'
			expect(html).toBe(expected)

		it 'correctly empties the collection when an empty array is used', ->
			binding = createBinding()
			binding.setValue(createData(), createContext())
			expect(binding.root.innerHTML).not.toBe('')
			binding.setValue([], createContext())
			expect(binding.root.innerHTML).toBe('')

		it 'hooks events on sub views', ->
			binding = createBinding()
			context = createContext()
			bootstrapper = context.presenter.bootstrapper

			spyOn(bootstrapper, 'hookEvents')
			binding.setValue(context.model.data, context)

			expect(bootstrapper.hookEvents.calls.length).toBe(2)
			expect(bootstrapper.hookEvents.calls[0].args[1].itemAccessor.source).toBe(context.model)
			expect(bootstrapper.hookEvents.calls[0].args[1].itemAccessor.path).toBe('data')
			expect(bootstrapper.hookEvents.calls[0].args[1].itemAccessor.itemIndex).toBe(0)
			expect(bootstrapper.hookEvents.calls[0].args[1].view).toBe(binding.views[0])

			expect(bootstrapper.hookEvents.calls[1].args[1].itemAccessor.source).toBe(context.model)
			expect(bootstrapper.hookEvents.calls[1].args[1].itemAccessor.path).toBe('data')
			expect(bootstrapper.hookEvents.calls[1].args[1].itemAccessor.itemIndex).toBe(1)
			expect(bootstrapper.hookEvents.calls[1].args[1].view).toBe(binding.views[1])
			
	describe 'when getting values', ->
		it 'correctly reads the collections', ->
			binding = createBinding()
			binding.setValue(createData(), createContext())
			__$(binding.root).elementsWithAttribute('data-bind')[0].innerHTML = 'Jack'
			data = binding.getValue(createContext())
			expect(data.length).toBe(2)
			expect(data[0].name).toBe('Jack')