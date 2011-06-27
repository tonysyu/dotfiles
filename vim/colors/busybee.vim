" Maintainer:	Patrick J. Anderson
" Version:      1.0.1
" Last Change:	February 23, 2009
" Credits:      This is a modification of Mustang.vim color scheme

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "busybee"

if has("gui_running")
    " Vim >= 7.0 specific colors
    if version >= 700
      hi CursorLine                     guibg=#262626
      hi CursorColumn                   guibg=#202020
      hi MatchParen     guifg=#d0ffc0   guibg=#202020   gui=bold
      hi Pmenu 		    guifg=#ffffff   guibg=#202020
      hi PmenuSel 	    guifg=#000000   guibg=#b1d631
    endif

    " General colors
    hi ColorColumn                      guibg=#333333
    hi Cursor 		    guifg=NONE      guibg=#626262   gui=none
    hi Normal 		    guifg=#e2e2e5   guibg=#202020   gui=none
    hi NonText 		    guifg=#808080   guibg=#202020   gui=none
    hi LineNr 		    guifg=#444444   guibg=#202020   gui=none
    hi StatusLine 	    guifg=#d3d3d5   guibg=#303030   gui=none
    hi StatusLineNC     guifg=#939395   guibg=#303030   gui=none
    hi VertSplit 	    guifg=#444444   guibg=#303030   gui=none
    hi Folded 		    guifg=#a0a8b0   guibg=#384048   gui=none
    hi Title		    guifg=#f6f3e8   guibg=NONE	    gui=bold
    hi Visual		    guifg=#202020   guibg=#e2e2e5   gui=none
    hi SpecialKey	    guifg=#808080   guibg=#343434   gui=none

    " Syntax highlighting
    hi Comment 		    guifg=#555555                   gui=italic
    hi Todo 		    guifg=#8f8f8f                   gui=none
    hi Boolean          guifg=#b1d631                   gui=none
    hi String 		    guifg=#777777                   gui=none
    hi Identifier 	    guifg=#b1d631                   gui=none
    hi Function 	    guifg=#ffff44                   gui=none
    hi Type 		    guifg=#7e8aa2                   gui=none
    hi Statement 	    guifg=#7e8aa2                   gui=none
    hi Keyword		    guifg=#ff9800                   gui=none
    hi Constant 	    guifg=#ff9800                   gui=none
    hi Number		    guifg=#ff9800                   gui=none
    hi Special		    guifg=#ff9800                   gui=none
    hi PreProc 		    guifg=#faf4c6                   gui=none
    hi Todo             guifg=#ff9f00   guibg=#202020   gui=none

    " VimDiff highlighting
    hi DiffAdd          guifg=#202020   guibg=#b1d631   gui=none
    hi DiffChange       guifg=#202020   guibg=#ff9800   gui=none
    hi DiffDelete       guifg=#202020   guibg=#ff6545   gui=none
    hi DiffText         guifg=#202020   guibg=#86cbfc   gui=none
endif

