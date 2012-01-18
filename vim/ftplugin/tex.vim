let b:surround_40 = "\\left(\r\\right)"           " 40 in ASCII = '('
let b:surround_91 = "\\left[\r\\right]"           " 40 in ASCII = '['

" add styling to letter under cursor
nnoremap <leader>hat a}<ESC>hi\hat{<ESC>l
nnoremap <leader>vec a}<ESC>hi\vec{<ESC>l
nnoremap <leader>emph a}<ESC>hi\emph{<ESC>l
nnoremap <leader>tbf a}<ESC>hi\textbf{<ESC>l
nnoremap <leader>mbf a}<ESC>hi\mathbf{<ESC>l

" horizontal line of characters
function! Hline(char)
    return '%' . repeat(a:char, 78)
endfunction

" Set taglist for latex
let tlist_tex_settings = 'latex;l:labels;s:sections;t:subsections;u:subsubsections'

" Add ‘-’ and ‘:’ to keywords
setlocal iskeyword=@,48-57,_,-,:,192-255

nnoremap <leader>r :w<CR>:Latexmk<CR>

"nnoremap <leader>l :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf %<CR>

"let g:Tex_MainFileExpression = 'MainFile(modifier)'
"function! MainFile(fmod)
    "if glob('*.latexmain') != ''
        "return fnamemodify(glob('*.latexmain'), a:fmod)
    "else
        "return ''
    "endif
"endif

" Latex-box customization.
let g:LatexBox_viewer = '/Applications/Preview.app/Contents/MacOS/Preview'

" begin and end environment
imap <buffer> [[ \begin{
imap <buffer> ]] <Plug>LatexCloseCurEnv

" Wrap visual selection in a new environment
vmap <leader>ee <Plug>LatexEnvWrapSelection
" Change environment
nmap <leader>ee <Plug>LatexChangeEnv

