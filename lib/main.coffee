_ = require 'underscore-plus'
{CompositeDisposable} = require 'atom'

getView = (model) ->
  atom.views.getView(model)

module.exports =
  paneContainerElement: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscribe atom.commands.add 'atom-workspace',
      'focus-pane-or-panel-above': => @focusPaneOrPanel('up', "window:focus-pane-above")
      'focus-pane-or-panel-below': => @focusPaneOrPanel('down', "window:focus-pane-below")
      'focus-pane-or-panel-on-left': => @focusPaneOrPanel('left', "window:focus-pane-on-left")
      'focus-pane-or-panel-on-right': => @focusPaneOrPanel('right', "window:focus-pane-on-right")

  deactivate: ->
    @subscriptions?.dispose()
    {@subscriptions, @paneContainerElement} = {}

  subscribe: (arg) ->
    @subscriptions.add(arg)

  # left, right, up, down
  getPanels: (direction) ->
    atom.workspace["get#{_.capitalize(direction)}Panels"]()

  getVisiblePanels: (direction) ->
    @getPanels(direction).filter (panel) -> panel.isVisible()

  getFocusedPanels: (direction) ->
    @getVisiblePanels(direction).filter (panel) -> panel.getItem().hasFocus?()

  getPanelElement: (direction) ->
    getView(atom.workspace.panelContainers[direction])

  # panelHasFocused: ->
  #   @getPanelElement('left').contains(document.activeElement) or
  #     @getPanelElement('right').contains(document.activeElement)

  paneHasFocused: ->
    @paneContainerElement ?= getView(atom.workspace.getActivePane().getContainer())
    @paneContainerElement.contains(document.activeElement)

  focusPaneOrPanel: (direction, commandName) ->
    if @paneHasFocused()
      activePaneChanged = false
      disposable = atom.workspace.onDidChangeActivePane ->
        activePaneChanged = true

      atom.commands.dispatch(getView(atom.workspace), commandName)
      @focusNextPanel(direction) unless activePaneChanged
      disposable.dispose()
    else
      atom.workspace.getActivePane().activate()

  focusNextPanel: (direction) ->
    panel = @getNextPanel(direction)
    panel?.getItem().focus?()

  getNextPanel: (direction) ->
    switch direction
      when 'up' then _.last(@getVisiblePanels('top'))
      when 'down' then _.first(@getVisiblePanels('bottom'))
      when 'left' then _.last(@getVisiblePanels('left'))
      when 'right' then _.first(@getVisiblePanels('right'))
