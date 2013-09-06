class Collection extends atlas.binding.Base
	Binder = require 'atlas/binding/binder'

	views: []
	usesExplicitTemplate: false

	convertDisplayBinding: (base, @root) ->
		for prop, value of base
			@[prop] = value unless _.isFunction(base[prop])
		
		if @root.hasAttribute('data-template')
			templateName = @root.getAttribute('data-template')
			findTemplate = (parent) ->
				return [null,null] unless parent.hasChildNodes()
				for child in parent.childNodes
					return [parent, child] if child.getAttribute?('data-template-name') is templateName
					[container, template] = findTemplate(child)
					return [container, template] if container? and template?
				[null,null]

			[@containerNode, templateNode] = findTemplate(@root)
			@root = __$('')
			@template = templateNode.outerHTML
			@createPlaceholderNode(@containerNode, templateNode)
			@containerNode.removeChild(templateNode)
			@usesExplicitTemplate = true
		else
			@containerNode = @root
			@template = @root.firstElementChild.outerHTML
			@usesExplicitTemplate = false
		@
			
	setValue: (value, context) ->
		# OPTIMIZATION - Calculate deltas instead of rebuilding entire collection
		@views = []
		@containerNode ?= @root
		value ?= []
		
		if @usesExplicitTemplate
			toRemove = (child for child in @containerNode.childNodes when child.hasAttribute?('data-collection-item'))
			firstItemNode = _.find(toRemove, (node)->node.getAttribute('data-collection-item') is '1')
			@createPlaceholderNode(@containerNode, firstItemNode) if firstItemNode?
			@containerNode.removeChild(node) for node in (toRemove ? [])
		@root.innerHTML = ''
		
		itemIndex = 1
		for item in value
			el = __$(@template).firstElementChild	# DOM function wraps with outer div
			el.setAttribute('data-collection-item', itemIndex++)
			@root.appendChild(el)
			view = new atlas.core.View(el)
			bindingContext = 
				model: item
				presenter: context.presenter
			# TODO - Hook events
			Binder.bind(b, bindingContext) for b in view.bindings
			@views.push view

		if @usesExplicitTemplate and value.length > 0
			placeholderNode = __$(@containerNode).elementsWithAttribute('data-placeholder')?[0]
			if placeholderNode?
				referenceNode = placeholderNode.nextSibling
				@containerNode.insertBefore(itemNode, referenceNode) for itemNode in _.toArray(@root.childNodes)
				@containerNode.removeChild(placeholderNode)

	getValue: (context) ->
		ret = []
		for view in @views
			item = {}
			bindingContext =
				model: item
				presenter: context.presenter
			Binder.read(b, bindingContext) for b in view.bindings
			ret.push item
		ret

	createPlaceholderNode: (parent, at) ->
		el = __$('')
		el.setAttribute('data-placeholder', 'collection')
		parent.insertBefore(el, at)