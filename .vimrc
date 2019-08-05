" Set version info and set wrapmargin to ten
version 7.4
" wrap margin
set wm=10
" :set tw=69
" :set aw

" store swap and backup files in $TMP
:set directory=/home/dsj/tmp
:set backupdir=/home/dsj/tmp

" reread files into buffers if they change on disk
" such as with changing git branches...
set autoread
au CursorHold * checktime

set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a

set colorcolumn=
" auto indent
set ai
" smart indent
set si
" line numbers
set number

" I like a larger history file
set history=1000



" Add ability to comment out blocks of lines (need line numbers)
" Use Shift-v then press '#'.  Press '-#' to remove (with Shft-v)
vnoremap # :s#^#\##<cr>
vnoremap -# :s#^\###<cr>

"""""""""""""""""""""""""""""""""""""
""""" Vim Plugins from YouTube  """""
"""""""""""""""""""""""""""""""""""""
" for Pathogen et al
execute pathogen#infect()
"syntax on
filetype plugin indent on

" EMMET is enabled in the HTML section

" enable fuzzy file finder
set rtp+=~/.fzf

" improve the status line
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%{fugitive#statusline()}
set statusline+=%*

" enable syntax checking
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" for indentLine
let g:indentLine='|'
let g:indentLine_setColrs = 0

" For C and Python files
"
" All setting are protected by 'au' (autocmd) statements. Only 
" files ending in .py or pyw will trigger the Python settings while
" files ending in *.c or *.h will trigger the C settings.  This makes
" the file "safe" in terms of only adjusting settings for Python and
" C files.


" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for new tab use shiftwidth.
set ruler 
au BufRead,BufNewFile *py,*pyw*.c,*.h,*.pl,*.pm set tabstop=4

" What to use for an indent.  This will affect Ctl-T and
" 'autoindent'.  Python: 4 spaces
au BufRead,BufNewFile *.py,*pyw,*.pl,*.pm set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw,*.pl,*.pm set expandtab
fu Select_c_style()
	if search('^\t', 'n', 150)
		set shiftwidth=8
		set noexpandtab
	el
		set shiftwidth=4
		set expandtab
	en
endf
au BufRead,BufNewFile *.c,*.h call Select_c_style()
au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is
" desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw,*.pl,*.pm match BadWhitespace /^\t\+/

" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.pl,*.pm match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 79
" C: 79
au BufRead,BufNewFile *.py,*.pyw,*.c*.h set textwidth=79

" Turn off settings in 'formatoptions' relating to comment
" formatting.  -c : do not automatically insert the comment leader
" when wrapping is based on 'textwidth'
" -o : do not insert the comment leader when using 'o' or 'O' from
"  command mode
"  -r : do not insert the comment leacder when hitting <Enter> in
"  insert mode
"  Python: not needed
"  C: prevents insertion of '*' at the beginning of every line in a
"  comment.
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings
" Only used for new files so as to not force existing files to change
" their line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.c,*.h,*.pl,*.pm set fileformat=unix

" Some terminfo stuff.  Hey, it was recommended by 
" someone or other! :-)
":if has("terminfo")
":  set t_Co=8
":  set t_Sf=[3%p1%dm
":  set t_Sb=[4%p1%dm
":else
":  set t_Co=8
":  set t_Sf=[3%dm
":  set t_Sb=[4%dm
":endif

if &term == "xterm"
  set term=xterm-color
else 
  set term=$TERM
endif  

" ########  THOUGHTBOT  ##############
" Got this from thoughtbot
set nocompatible
"syntax enable
"filetype plugin on
set path+=**
set wildmenu

" I gotsta have my syntax!  " overcome by syntax enable
":syntax on

"===================================
"  Latex  Latex  Latex  Latex  Latex
"===================================

:iab Ljdate \noindent {\bf <C-R>=strftime("%A, %B %d, %Y---")<CR>}
:iab LLatex \documentclass[12pt]{article}\raggedright\parindent.25in\begin{document}
:iab Lnoi \noindent
:iab Lbf {\bf}i
:iab Lit {\it}i
:iab Ltt {\tt}i
:iab Lenum \begin{enumerate}\item\end{enumerate}kka
:iab Litemi \begin{itemize}\item\end{itemize}kka
:iab Li \itema
:iab Lti \begin{center}{\bf}\end{center}klllllla
:iab Lno %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ka
:iab La \LaTeX\

"===================================
" Useful Mappings
"===================================
:iab Ytime <C-R>=strftime("%A, %B %d, %Y")<CR>

:map _n 0i#j0

" turn on NERDTree
:map <C-n> :NERDTree<CR>

"===================================
" Mappings for editing my .vimrc
"===================================

:iab Vno "=======================================" "=======================================ka

"=======================================
"  HTML  HTML  HTML  HTML  HTML  HTML
"=======================================

" enable EMMET
let g:user_emmet_mode='a'    "enable all function in all mode."

"==============================
"    C and C++ macros
"==============================
:iab Cii #include <iostream.h>
:iab Cis #include <stdlib.h>

"==============================
"   Vimspell external script
"==============================
noremap <F8> :so `/home/dsj/bin/vimspell %`:!/home/dsj/bin/vimspell % -r


set t_Co=256
colorscheme xoria256
"colorscheme elflord
"colorscheme writer
"colorscheme pablo
"colorscheme desert
"colorscheme ron
"colorscheme slate
"colorsheme papaya
"colorsheme underflow
set background=dark
syntax on
