vim-ctrlp-session
=================

CtrlP extension to manage *Vim* sessions.

Features
========

Improve *Vim* session experience:

    - Fuzzy search sessions
    - Create sessions tracking Git branches
    - One configurable location for storing all session files.
    - Fast context switching

Requirements
============

To get the most value out of this plugin, you need these plugins to be
installed:

- [CtrlP](https://github.com/kien/ctrlp.vim)
- [vim-fugitive](https://github.com/tpope/vim-fugitive)

Installation
=============

This assumes you are using [Vundle](https://github.com/gmarik/Vundle.vim).
Adapt for your plugin manager of choice. Put this into your `.vimrc`.

    Plugin 'okcompute/vim-ctrlp-session'

Usage
=====

### `:Session {name}`

Create a session with name. Session will be automatically tracked.

### `:SGit`

Like :*Session* but use current repository name and branch to create the
name.  i.e.  (`repository@branch`.)

**Requires** [Tpope/vim-fugitive] (https://github.com/tpope/vim-fugitive)

### `:SLoad {name}`

Load session with {name}.

### `:SDelete {name}`

Delete sessio with {name}.

### `:SQuit`

Stop tracking current active session and close all buffers.

### `:SList`

List all available sessions.

### `:CtrlPSession`

Launch CtrlP prompt for fuzzy searching available sessions.

**Requires** [Kien/ctrlp.vim] (https://github.com/kien/ctrlp.vim)


CtrlP specific mappings
=======================

Once inside CtrlP prompt:

### `<c-x>`

Delete the session under cursor.

Credits
=======

This plugin implementation was inspired by :

- [tpope/vim-obsession] (https://github.com/tpope/vim-obsession)

    Helped me better understand how to correctly manage sessions.

- [Manual-colmenero/vim-simple-session] (https://github.com/Manuel-colmenero/vim-simple-session)

    This plugin was the initiator. I was a user and liked the idea. But it was
    buggy. I tried to debug it but the process of creating a new plugin was too
    appealing.


License
=======

Copyright © Pascal Lalancette. Distributed under the same terms as Vim itself. See :help license.
