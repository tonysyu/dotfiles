" Custom overrides for syntax highlighting
"
" vim-HiLinkTrace defines a :HLT command for displaying highlight groups

" Filetype mappings
" ......................................................................
" Map Embedded Elixir files to `heex` treesitter filetype
autocmd BufNewFile,BufRead,BufFilePost *.html.eex set filetype=heex
" Map Phoenix LiveView Embedded Elixir files to `heex` treesitter filetype
autocmd BufNewFile,BufRead,BufFilePost *.html.leex set filetype=heex

" Generic syntax
" ......................................................................
" Invert colors of MatchParen in molokai colorscheme to avoid jumping cursor
hi MatchParen      guifg=#FD971F guibg=#000000 gui=bold
if &t_Co > 255
   hi MatchParen   ctermfg=208 ctermbg=233  cterm=bold
end

" Elixir
" ......................................................................
hi link elixirBlockDefinition Statement
hi link elixirDefine Statement
hi link elixirModuleDefine Statement
hi link elixirPrivateDefine Statement

" Javascript / Typescript
" ......................................................................

" Override default link to Error for some reserved words (e.g import) peitalin/vim-jsx-typescript
hi link typescriptReserved Keyword

" Currently, vim-polyglot defines `javaScriptLineComment`, but doesn't link it to `Comment`
hi link javaScriptLineComment Comment
