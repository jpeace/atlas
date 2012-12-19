ElementWrapper = require 'atlas/dom/element_wrapper'

efs = tests.dom.elementFromString

describe 'Element Wrapper', ->
  describe 'styles', ->
    it 'can set styles', ->
      el = efs()
      wrapper = new ElementWrapper(el)
      wrapper.setStyle
        'margin-top' : '50px', 
        'border': '1px solid black'

      expect(el.style['margin-top']).toBe('50px')
      expect(el.style.border).toBe('1px solid black')

    it 'can get styles', ->
      el = efs('<div style="background-color:black;"></div>').childNodes[0]
      wrapper = new ElementWrapper(el)

      expect(wrapper.getStyle('background-color')).toBe('black')

  describe 'CSS classes', ->
    it 'can add CSS classes', ->
      el = efs('<div></div>').childNodes[0]
      wrapper = new ElementWrapper(el)
      wrapper.addClass('class1')
      expect(el.className).toBe('class1')

      wrapper.addClass('class2')
      expect(el.className).toBe('class1 class2')
    
    it 'only add CSS classes once', ->     
      el = efs('<div></div>').childNodes[0]
      wrapper = new ElementWrapper(el)
      wrapper.addClass('class1')
      wrapper.addClass('class1')
      expect(el.className).toBe('class1')

    it 'can remove CSS classes', ->
      el = efs('<div class="class1 class2"></div>').childNodes[0]
      wrapper = new ElementWrapper(el)
      wrapper.removeClass('class1')
      expect(el.className).toBe('class2')

    it 'can test for CSS classes', ->
      el = efs('<div class="class1"></div>').childNodes[0]
      wrapper = new ElementWrapper(el)
      expect(wrapper.hasClass('class1')).toBeTruthy()
      expect(wrapper.hasClass('class2')).toBeFalsy()