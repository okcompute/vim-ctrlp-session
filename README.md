vim-ctrlp-session
=================

CtrlP extension to manage *Vim* sessions.

Features
========

Improve *Vim* session experience:

    - Fuzzy search sessions
    - Create sessions tracking Git branches
    - One configurable location for all session files.
    - Fast context switching

Most useful when working within gVim (or MacVim) or on platforms where session
switching tools (ex: TMux) are not common place (Windows...ahem...).

Requirements
============

For this plugin to more value, you need these plugins to be installed:
    - [CtrlP](https://github.com/kien/ctrlp)
    - [vim-fugitive](https://github.com/tpope/vim-fugitive)

Installation
=============

Vundle:

`Plugin 'okcompute\vim-ctrlp-session'`

Usage
=====

These commands are available only for *python* file type buffers.

### `:Session {name}`

Create a session with name. Session will be automatically tracked.

### `:SGit

Like `:`|Session| but use current repository name and branch to create the
name.  i.e.  (`repository@branch`.)

** Requires 'Tpope/vim-fugitive' **

### `:SLoad {name}

Load session with {name}.

### `:SDelete {name}

Delete sessio with {name}.

### `:SQuit

Stop tracking current active session and close all buffers.

### `:SList

List all available sessions.

### `:CtrlpSession

Launch CtrlP prompt for fuzzy searching available sessions.

** Requires 'Kien/ctrlp.vim' **


License
=======

Copyright © Pascal Lalancette. Distributed under the same terms as Vim itself. See :help license.
