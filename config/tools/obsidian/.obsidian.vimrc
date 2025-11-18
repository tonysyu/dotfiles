" Have C-j and C-k navigate visual lines rather than logical ones
nmap <C-j> gj
nmap <C-k> gk

" Yank to system clipboard
" DISABLE: Although this works, it's really annoying since it puts all yanked text into
" the system clipboard, including text that's deleted. For example, if you delete some
" text and try to paste from the system clipboard, it pastes the deleted text.
" set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward
