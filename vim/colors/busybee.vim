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
      hi CursorColumn                   guibg=#181818
      hi CursorLine                     guibg=#262626
      hi MatchParen     guifg=#d0ffc0   guibg=#181818   gui=bold
      hi Pmenu 		    guifg=#ffffff   guibg=#262626
      hi PmenuSel 	    guifg=#000000   guibg=#b1d631
    endif

    " General colors
    hi ColorColumn                      guibg=#333333
    hi Cursor 		    guifg=NONE      guibg=#626262   gui=none
    hi Folded 		    guifg=#a0a8b0   guibg=#384048   gui=none
    hi LineNr 		    guifg=#444444   guibg=#181818   gui=none
    hi NonText 		    guifg=#808080   guibg=#181818   gui=none
    hi Normal 		    guifg=#e2e2e5   guibg=#181818   gui=none
    hi SpecialKey	    guifg=#808080   guibg=#343434   gui=none
    hi StatusLine 	    guifg=#d3d3d5   guibg=#303030   gui=none
    hi StatusLineNC     guifg=#939395   guibg=#303030   gui=none
    hi Title		    guifg=#f6f3e8   guibg=NONE	    gui=bold
    hi VertSplit 	    guifg=#444444   guibg=#303030   gui=none
    hi Visual		    guifg=#181818   guibg=#e2e2e5   gui=none

    " Syntax highlighting
    hi Boolean          guifg=#b1d631                   gui=none
    hi Comment 		    guifg=#555555                   gui=italic
    hi Constant 	    guifg=#ff9800                   gui=none
    hi Function 	    guifg=#ffff66                   gui=none
    hi Identifier 	    guifg=#b1d631                   gui=none
    hi Keyword		    guifg=#ff9800                   gui=none
    hi Number		    guifg=#ff9800                   gui=none
    hi Operator         guifg=#ff874f                   gui=none
    hi PreProc 		    guifg=#faf4c6                   gui=none
    hi Special		    guifg=#ff9800                   gui=none
    hi Statement 	    guifg=#85a5ff                   gui=none
    hi String 		    guifg=#888888                   gui=none
    hi Todo             guifg=#ff9800   guibg=#181818   gui=none
    hi Type 		    guifg=#85a5ff                   gui=none

    " VimDiff highlighting
    hi DiffAdd          guifg=#181818   guibg=#b1d631   gui=none
    hi DiffChange       guifg=#181818   guibg=#ff9800   gui=none
    hi DiffDelete       guifg=#181818   guibg=#ff6545   gui=none
    hi DiffText         guifg=#181818   guibg=#86cbfc   gui=none
endif

