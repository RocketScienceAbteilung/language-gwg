LanguageGwgView = require './language-gwg-view'
{CompositeDisposable} = require 'atom'

module.exports = LanguageGwg =
  languageGwgView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @languageGwgView = new LanguageGwgView(state.languageGwgViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @languageGwgView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'language-gwg:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @languageGwgView.destroy()

  serialize: ->
    languageGwgViewState: @languageGwgView.serialize()

  toggle: ->
    console.log 'LanguageGwg was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
