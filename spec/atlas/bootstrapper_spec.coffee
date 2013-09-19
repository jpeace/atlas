Bootstrapper = require 'atlas/bootstrap'

elementFromString = tests.dom.elementFromString
createEvent = tests.dom.createEvent
simpleDocument = tests.dom.simpleDocument
namespacedDocument = tests.dom.namespacedDocument
documentWithControls = tests.dom.documentWithControls
documentWithBehaviors = tests.dom.documentWithBehaviors

obj = 
  ping: (arg) -> 
      
class SampleBehavior
  configure: (element, arg) ->
    obj.ping(arg)
atlas.addBehavior('tests','sample',SampleBehavior)

getBootstrapper = (html) ->
  b = new Bootstrapper(elementFromString(html))
  b.bootstrap()
  return b

describe 'Bootstrapper', ->
  describe 'when bootstrapping', ->
    it 'finds all presenters', ->
      b = getBootstrapper(simpleDocument)
      expect(b.presenters.length).toBe(2)
      
    it 'finds namespaced presenters', ->
      b = getBootstrapper(namespacedDocument)
      expect(b.presenters.length).toBe(2)

    it 'configures behaviors', ->
      spyOn(obj, 'ping')
      b = getBootstrapper(documentWithBehaviors)

      expect(obj.ping).toHaveBeenCalledWith('argument')
      
  describe 'when hooking events', ->
    it 'sets up conventional hooks', ->
      bootstrapper = new Bootstrapper()
      view = new atlas.core.View(elementFromString(documentWithControls).childNodes[0])
      presenter = new atlas.presenters.Two(view, bootstrapper)
      button = __$(view.root).elementsWithAttribute('data-name')[0]

      spyOn(presenter, 'changeClicked').andCallThrough()
      bootstrapper.hookEvents(presenter)
      
      expect(presenter.model().user.firstName).toBe('Bob')      
      button.dispatchEvent(createEvent('click'))
      expect(presenter.changeClicked).toHaveBeenCalled()
      eventInfo = presenter.changeClicked.mostRecentCall.args[0]
      expect(eventInfo).not.toBeNull()
      expect(eventInfo.event).not.toBeNull()
      expect(presenter.model().user.firstName).toBe('Changed')

    it 'can work on sub views', ->
      html =  """
              <div class="subview-one">
                <button class="change-one" data-name="change">Change One</button>
              </div>
              <div class="subview-two">
                <button class="change-two" data-name="change">Change Two</button>
              </div>
              """
      bootstrapper = new Bootstrapper()
      masterView = new atlas.core.View(elementFromString(html))
      subViewOne = new atlas.core.View(__$(masterView.root).elementsWithClass('subview-one')[0])
      subViewTwo = new atlas.core.View(__$(masterView.root).elementsWithClass('subview-two')[0])
      button = __$(masterView.root).elementsWithClass('change-two')[0]
      presenter = new atlas.presenters.Two(masterView, bootstrapper)

      spyOn(presenter, 'changeClicked')
      bootstrapper.hookEvents(presenter, {view:subViewOne})
      bootstrapper.hookEvents(presenter, {view:subViewTwo})

      button.dispatchEvent(createEvent('click'))
      expect(presenter.changeClicked.calls.length).toBe(1)

    it 'passes the acted upon item when given', ->
      bootstrapper = new Bootstrapper()
      view = new atlas.core.View(elementFromString(documentWithControls).childNodes[0])
      presenter = new atlas.presenters.Two(view, bootstrapper)
      button = __$(view.root).elementsWithAttribute('data-name')[0]
      itemAccessor = {
        source: presenter.model(),
        path: 'user.friends',
        itemIndex: 1
      }

      spyOn(presenter, 'changeClicked')
      bootstrapper.hookEvents(presenter, {itemAccessor:itemAccessor})

      button.dispatchEvent(createEvent('click'))
      eventInfo = presenter.changeClicked.mostRecentCall.args[0]
      expect(eventInfo.item).toBe(presenter.model().user.friends[1])

    it 'works with multiple controls', ->
      html =  """
              <button data-name="change">Change</button>
              <button data-name="other">Other</button>
              """
      bootstrapper = new Bootstrapper()
      view = new atlas.core.View(elementFromString(html))
      presenter = new atlas.presenters.Two(view, bootstrapper)
      changeButton = __$(view.root).elementsWithAttribute('data-name')[0]
      
      spyOn(presenter, 'changeClicked')
      bootstrapper.hookEvents(presenter)
      
      changeButton.dispatchEvent(createEvent('click'))
      expect(presenter.changeClicked).toHaveBeenCalled()