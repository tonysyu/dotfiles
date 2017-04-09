
setlocal tabstop=3                   " tab is 3 spaces
setlocal shiftwidth=3                " indentation in normal mode is 3 spaces
setlocal softtabstop=3               " back space removes up-to 3 spaces

" Section headings for reStructuredText
" Parts
noremap  <leader>0 yyPVr#yyjp
inoremap <leader>0 <esc>yyPVr#yyjpA
" Chapters
noremap  <leader>1 yyPVr=yyjp
inoremap <leader>1 <esc>yyPVr=yyjpA
" Section Level 1
noremap  <leader>2 yypVr=
inoremap <leader>2 <esc>yypVr=A
" Section Level 2
noremap  <leader>3 yypVr-
inoremap <leader>3 <esc>yypVr-A
" Section Level 3
noremap  <leader>4 yypVr.
inoremap <leader>4 <esc>yypVr.A
