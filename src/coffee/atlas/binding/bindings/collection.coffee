class Collection extends atlas.binding.Base
	Binder = require 'atlas/binding/binder'

	views: []

	convertDisplayBinding: (base, @root) ->
		for prop, value of base
			@[prop] = value unless _.isFunction(base[prop])
		# TODO - Find explicitly marked templates
		@template = @root.firstElementChild.outerHTML
		@
			
	setValue: (value, context) ->
		# OPTIMIZATION - Calculate deltas instead of rebuilding entire collection
		@views = []
		@root.innerHTML = ''
		html = ''
		for item in value
			el = __$(@template).firstElementChild	# DOM function wraps with outer div
			@root.appendChild(el)
			view = new atlas.core.View(el)
			bindingContext = 
				model: item
				presenter: context.presenter
			# TODO - Hook events
			Binder.bind(b, bindingContext) for b in view.bindings
			@views.push view

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