
setlocal tabstop=3                   " tab is 3 spaces
setlocal shiftwidth=3                " indentation in normal mode is 3 spaces
setlocal softtabstop=3               " back space removes up-to 3 spaces

" Section headings for reStructuredText
" Parts
noremap  <C-h>0 yyPVr#yyjp
inoremap <C-h>0 <esc>yyPVr#yyjpA
" Chapters
noremap  <C-h>1 yyPVr=yyjp
inoremap <C-h>1 <esc>yyPVr=yyjpA
" Section Level 1
noremap  <C-h>2 yypVr=
inoremap <C-h>2 <esc>yypVr=A
" Section Level 2
noremap  <C-h>3 yypVr-
inoremap <C-h>3 <esc>yypVr-A
" Section Level 3
noremap  <C-h>4 yypVr.
inoremap <C-h>4 <esc>yypVr.A
