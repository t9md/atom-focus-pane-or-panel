# focus-pane-or-panel

Change focus or pane or panel seamlessly.

# keymaps

No keymap by default.

```coffeescript
'atom-text-editor.vim-mode-plus.normal-mode':
  'ctrl-j': 'focus-pane-or-panel-below'
  'ctrl-k': 'focus-pane-or-panel-above'
  'ctrl-h': 'focus-pane-or-panel-on-left'
  'ctrl-l': 'focus-pane-or-panel-on-right'

'.tree-view':
  'ctrl-h': 'focus-pane-or-panel-on-left'
  'ctrl-l': 'focus-pane-or-panel-on-right'

'.platform-darwin .find-and-replace atom-text-editor':
  'ctrl-j': 'focus-pane-or-panel-below'
  'ctrl-k': 'focus-pane-or-panel-above'

'.platform-darwin .project-find atom-text-editor':
  'ctrl-j': 'focus-pane-or-panel-below'
  'ctrl-k': 'focus-pane-or-panel-above'
```
