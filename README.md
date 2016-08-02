# focus-pane-or-panel

Change focus of pane or panel seamlessly.

# keymaps example  

No keymap by default.  

#### very basic

```coffeescript
'body':
  'cmd-k cmd-up': 'focus-pane-or-panel-above'
  'cmd-k cmd-down': 'focus-pane-or-panel-below'
  'cmd-k cmd-left': 'focus-pane-or-panel-on-left'
  'cmd-k cmd-right': 'focus-pane-or-panel-on-right'
```

#### mine(I'm vim-mode-plus user).

want to change focus by ctrl-hjkl

```coffeescript
'atom-text-editor.vim-mode-plus.normal-mode':
  'ctrl-j': 'focus-pane-or-panel-below'
  'ctrl-k': 'focus-pane-or-panel-above'
  'ctrl-h': 'focus-pane-or-panel-on-left'
  'ctrl-l': 'focus-pane-or-panel-on-right'

'.tree-view':
  'ctrl-h': 'focus-pane-or-panel-on-left'
  'ctrl-l': 'focus-pane-or-panel-on-right'

# for cmd-f panel
'.platform-darwin .find-and-replace atom-text-editor':
  'ctrl-j': 'focus-pane-or-panel-below'
  'ctrl-k': 'focus-pane-or-panel-above'

# for cmd-shift-f panel
'.platform-darwin .project-find atom-text-editor':
  'ctrl-j': 'focus-pane-or-panel-below'
  'ctrl-k': 'focus-pane-or-panel-above'
```
