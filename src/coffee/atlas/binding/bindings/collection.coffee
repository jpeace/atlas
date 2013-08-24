class Collection extends atlas.binding.Base
	Binder = require 'atlas/binding/binder'
	
	convertDisplayBinding: (base, @root) ->
		for prop, value of base
			@[prop] = value unless _.isFunction(base[prop])
		@template = @root.firstElementChild.outerHTML
		@
			
	setValue: (value, context) ->
		@root.innerHTML = ''
		html = ''
		for item in value
			el = __$(@template)
			@root.appendChild(el)
			view = new atlas.core.View(el)
			bindingContext = 
				model: item
				presenter: context.presenter
			# hook events
			Binder.bind(b, bindingContext) for b in view.bindings

		getValue: (context) ->