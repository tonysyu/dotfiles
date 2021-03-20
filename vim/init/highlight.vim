" Custom overrides for syntax highlighting
"
" vim-HiLinkTrace defines a :HLT command for displaying highlight groups

" Elixir
" ......................................................................
hi link elixirBlockDefinition Statement
hi link elixirDefine Statement
hi link elixirModuleDefine Statement
hi link elixirPrivateDefine Statement

" Typescript
" ......................................................................

" Override default link to Error for some reserved words (e.g import) peitalin/vim-jsx-typescript
hi link typescriptReserved Keyword
