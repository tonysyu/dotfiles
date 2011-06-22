" Description:  a color scheme derived from kellys.vim (version 0.4)
"  Maintainer:  tsyu80@gmail.com
"     License:  gpl 3+
"     Version:  0.1


set background=dark

if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

let colors_name = "tsy"

" black         2a2b2f  235
" blue          62acce  81
" blue slight   9ab2c8  74
" brown slight  d1c79e  144
" green yellowy d1d435  184
" grey dark     67686b  240
" grey light    e1e0e5  254
" orange        e6ac32  178
" red           9d0e15  124

" tabline

if has("gui_running")
    hi ColorColumn  guibg=#67686b
    hi Comment      guifg=#67686b   guibg=#2a2b2f   gui=none
    hi Cursor       guifg=#2a2b2f   guibg=#e1e0e5   gui=none
    hi Conceal      guifg=#e1e0e5   guibg=#67686b   gui=none
    hi Constant     guifg=#d1c79e   guibg=#2a2b2f   gui=none
    hi CursorLine                   guibg=#303132   gui=none
    hi DiffAdd      guifg=#2a2b2f   guibg=#9ab2c8   gui=none
    hi DiffChange   guifg=#2a2b2f   guibg=#d1c79e   gui=none
    hi DiffDelete   guifg=#67686b   guibg=#2a2b2f   gui=none
    hi DiffText     guifg=#9d0e15   guibg=#d1c79e   gui=none
    hi Error        guifg=#9d0e15   guibg=#2a2b2f   gui=underline
    hi Folded       guifg=#2a2b2f   guibg=#67686b   gui=none
    hi Function     guifg=#FFF214   guibg=#2a2b2f   gui=none
    hi MatchParen   guifg=#d1d435   guibg=#2a2b2f   gui=bold,underline
    hi ModeMsg      guifg=#e1e0e5   guibg=#2a2b2f   gui=bold
    hi Normal       guifg=#e1e0e5   guibg=#2a2b2f   gui=none
    hi Pmenu        guifg=#2a2b2f   guibg=#9ab2c8   gui=none
    hi PmenuSel     guifg=#2a2b2f   guibg=#62acce   gui=bold
    hi PmenuSbar    guifg=#2a2b2f   guibg=#2a2b2f   gui=none
    hi PmenuThumb   guifg=#2a2b2f   guibg=#62acce   gui=none
    hi PreProc      guifg=#d1d435   guibg=#2a2b2f   gui=none
    hi Search       guifg=#2a2b2f   guibg=#8d9c93   gui=none
    hi Special      guifg=#9ab2c8   guibg=#2a2b2f   gui=none
    hi SpecialKey   guifg=#4a4a59
    hi SpellBad     gui=underline
    hi Statement    guifg=#62acce   guibg=#2a2b2f   gui=bold
    hi StatusLine   guifg=#2a2b2f   guibg=#62acce   gui=bold
    hi StatusLineNC guifg=#2a2b2f   guibg=#e1e0e5   gui=none
    hi Todo         guifg=#e1e0e5   guibg=#9d0e15   gui=bold
    hi Type         guifg=#F8900A   guibg=#2a2b2f   gui=none
    hi Underlined   guifg=#e1e0e5   guibg=#2a2b2f   gui=underline
    hi Visual       guifg=#2a2b2f   guibg=#e1e0e5   gui=none
    hi Wildmenu     guifg=#62acce   guibg=#2a2b2f   gui=bold
elseif &t_Co == 256
    hi Comment      ctermfg=239 ctermbg=235 cterm=none
    hi Cursor       ctermfg=235 ctermbg=254 cterm=none
    hi Constant     ctermfg=144 ctermbg=235 cterm=none
    hi CursorLine               ctermbg=236 cterm=none
    hi DiffAdd      ctermfg=235 ctermbg=74  cterm=none
    hi DiffChange   ctermfg=235 ctermbg=144 cterm=none
    hi DiffDelete   ctermfg=239 ctermbg=235 cterm=none
    hi DiffText     ctermfg=124 ctermbg=144 cterm=none
    hi Folded       ctermfg=239 ctermbg=235 cterm=none
    hi MatchParen   ctermfg=184 ctermbg=235 cterm=bold,underline
    hi ModeMsg      ctermfg=254 ctermbg=235 cterm=bold
    hi Normal       ctermfg=254 ctermbg=235 cterm=none
    hi Pmenu        ctermfg=235 ctermbg=74  cterm=none
    hi PmenuSel     ctermfg=235 ctermbg=81  cterm=bold
    hi PmenuSbar    ctermfg=235 ctermbg=235 cterm=none
    hi PmenuThumb   ctermfg=235 ctermbg=81  cterm=none
    hi PreProc      ctermfg=184 ctermbg=235 cterm=none
    hi Search       ctermfg=235 ctermbg=254 cterm=none
    hi Special      ctermfg=74  ctermbg=235 cterm=none
    hi SpecialKey   ctermfg=254
    hi SpellBad     cterm=underline
    hi Statement    ctermfg=81  ctermbg=235 cterm=none
    hi StatusLine   ctermfg=235 ctermbg=81  cterm=bold
    hi StatusLineNC ctermfg=235 ctermbg=254 cterm=none
    hi Todo         ctermfg=254 ctermbg=124 cterm=bold
    hi Type         ctermfg=178 ctermbg=234 cterm=none
    hi Underlined   ctermfg=254 ctermbg=234 cterm=underline
    hi Visual       ctermfg=235 ctermbg=254 cterm=none
    hi Wildmenu     ctermfg=81  ctermbg=234 cterm=bold
elseif &t_Co < 256
    hi SpecialKey   ctermfg=DarkGray
    hi Comment      ctermfg=DarkGray
endif

hi! link Boolean        Constant
hi! link Character      Constant
hi! link Conditional    Statement
hi! link CursorColumn   CursorLine
hi! link Debug          Special
hi! link Define         PreProc
hi! link Delimiter      Special
hi! link Directory      Type
hi! link Error          Error
hi! link ErrorMsg       Error
hi! link Exception      Statement
hi! link Float          Constant
hi! link FoldColumn     Folded
hi! link Identifier     Special
hi! link Ignore         Comment
hi! link IncSearch      Search
hi! link Include        PreProc
hi! link Keyword        Statement
hi! link Label          Statement
hi! link LineNr         Comment
hi! link Macro          PreProc
hi! link MoreMsg        ModeMsg
hi! link NonText        SpecialKey
hi! link Number         Constant
hi! link Operator       Special
hi! link PreCondit      PreProc
hi! link Question       MoreMsg
hi! link Repeat         Statement
hi! link SignColumn     FoldColumn
hi! link SpecialChar    Special
hi! link SpecialComment Special
hi! link SpecialKey     Comment
hi! link SpellCap       SpellBad
hi! link SpellLocal     SpellBad
hi! link SpellRare      SpellBad
hi! link StorageClass   Type
hi! link String         Constant
hi! link Structure      Type
hi! link Tag            Special
hi! link Title          ModeMsg
hi! link Typedef        Type
hi! link VertSplit      StatusLineNC
hi! link WarningMsg     Error

" ada
hi! link adaBegin           Type
hi! link adaEnd             Type
hi! link adaKeyword         Special
" c++
hi! link cppAccess          Type
hi! link cppStatement       Special
" hs
hi! link ConId              Type
hi! link hsPragma           PreProc
hi! link hsConSym           Operator
" html
hi! link htmlArg            Statement
hi! link htmlEndTag         Special
hi! link htmlItalic         Underlined
hi! link htmlLink           Underlined
hi! link htmlSpecialTagName PreProc
hi! link htmlTag            Special
hi! link htmlTagName        Type
" java
hi! link javaTypeDef        Special
" lisp
hi! link lispAtom           Constant
hi! link lispAtomMark       Constant
hi! link lispConcat         Special
hi! link lispDecl           Type
hi! link lispFunc           Special
hi! link lispKey            PreProc
" netrw
hi! link netrwDir           Special
hi! link netrwExe           Wildmenu
hi! link netrwSymLink       Statement
" pas
hi! link pascalAsmKey       Statement
hi! link pascalDirective    PreProc
hi! link pascalModifier     PreProc
hi! link pascalPredefined   Special
hi! link pascalStatement    Type
hi! link pascalStruct       Type
" php
hi! link phpComparison      Special
hi! link phpDefine          Type
hi! link phpIdentifier      Normal
hi! link phpMemberSelector  Special
hi! link phpRegion          Special
hi! link phpVarSelector     Special
hi! link phpVarSelector     Special
" py
hi! link pythonStatement    Type
" rb
hi! link rubyConstant       Special
hi! link rubyDefine         Type
hi! link rubyRegexp         Special
" scm
hi! link schemeSyntax       Special
" sh
hi! link shArithRegion      Normal
hi! link shDerefSimple      Normal
hi! link shDerefVar         Normal
hi! link shFunction         Type
hi! link shLoop             Statement
hi! link shStatement        Special
hi! link shVariable         Normal
" sql
hi! link sqlKeyword         Statement
" tex
hi! link texDocType         PreProc
hi! link texLigature        Constant
hi! link texMatcher         Normal
hi! link texNewCmd          PreProc
hi! link texOnlyMath        Constant
hi! link texRefZone         Constant
hi! link texSection         Type
hi! link texSectionMarker   Type
hi! link texSectionModifier Constant
hi! link texTypeSize        Special
hi! link texTypeStyle       Special
" vim
hi! link vimCommand         Statement
hi! link vimCommentTitle    Normal
hi! link vimEnvVar          Special
hi! link vimFuncKey         Type
hi! link vimGroup           Special
hi! link vimHiAttrib        Constant
hi! link vimHiCTerm         Special
hi! link vimHiCtermFgBg     Special
hi! link vimHighlight       Special
hi! link vimHiGui           Special
hi! link vimHiGuiFgBg       Special
hi! link vimOption          Special
hi! link vimSyntax          Special
hi! link vimSynType         Special
hi! link vimUserAttrb       Special
" xml
hi! link xmlAttrib          Special
hi! link xmlCdata           Normal
hi! link xmlCdataCdata      Statement
hi! link xmlCdataEnd        PreProc
hi! link xmlCdataStart      PreProc
hi! link xmlDocType         PreProc
hi! link xmlDocTypeDecl     PreProc
hi! link xmlDocTypeKeyword  PreProc
hi! link xmlEndTag          Statement
hi! link xmlProcessingDelim PreProc
hi! link xmlNamespace       PreProc
hi! link xmlTagName         Statement
