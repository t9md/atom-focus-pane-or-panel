_ = require 'underscore-plus'
{CompositeDisposable} = require 'atom'

# Utils
# -------------------------
getView = (model) ->
  atom.views.getView(model)

getPanels = (position) ->
  atom.workspace["get#{_.capitalize(position)}Panels"]()

getVisiblePanels = (position) ->
  getPanels(position).filter (panel) -> panel.isVisible()

getOppositeDirection = (direction) ->
  switch direction
    when 'up' then 'down'
    when 'down' then 'up'
    when 'right' then 'left'
    when 'left' then 'right'

getFocusedPanelPosition = ->
  for position in ['top', 'bottom', 'left', 'right']
    if getView(atom.workspace.panelContainers[position]).contains(document.activeElement)
      return position
  null

panelPositionForDirection = (direction) ->
  switch direction
    when 'up' then 'top'
    when 'down' then 'bottom'
    else direction

directionForPanelPosition = (position) ->
  switch position
    when 'top' then 'up'
    when 'bottom' then 'down'
    else position

# Main
# -------------------------
module.exports =
  paneContainerElement: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscribe atom.commands.add 'atom-workspace',
      'focus-pane-or-panel:focus-above': => @focusPaneOrPanel('up', "window:focus-pane-above")
      'focus-pane-or-panel:focus-below': => @focusPaneOrPanel('down', "window:focus-pane-below")
      'focus-pane-or-panel:focus-on-left': => @focusPaneOrPanel('left', "window:focus-pane-on-left")
      'focus-pane-or-panel:focus-on-right': => @focusPaneOrPanel('right', "window:focus-pane-on-right")

  deactivate: ->
    @subscriptions?.dispose()
    {@subscriptions, @paneContainerElement} = {}

  subscribe: (arg) ->
    @subscriptions.add(arg)

  isPaneFocused: ->
    @paneContainerElement ?= getView(atom.workspace.getActivePane().getContainer())
    @paneContainerElement.contains(document.activeElement)

  focusPanelForDirection: (direction) ->
    position = panelPositionForDirection(direction)
    if (panels = getVisiblePanels(position)).length
      switch direction
        when 'up', 'left' then _.last(panels).getItem().focus?()
        when 'down', 'right' then _.first(panels).getItem().focus?()

  focusPaneOrPanel: (direction, commandName) ->
    if @isPaneFocused()
      activePaneChanged = false
      disposable = atom.workspace.onDidChangeActivePane ->
        activePaneChanged = true

      atom.commands.dispatch(getView(atom.workspace), commandName)
      @focusPanelForDirection(direction) unless activePaneChanged
      disposable.dispose()
    else
      panelDirection = directionForPanelPosition(getFocusedPanelPosition())
      if getOppositeDirection(panelDirection) is direction
        atom.workspace.getActivePane().activate()
