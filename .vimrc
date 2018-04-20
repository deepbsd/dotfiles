" Set version info and set wrapmargin to ten
"version 7.5
:set wm=10
:set tw=80
:set aw
:set ai
:set number

" Add ability to comment out blocks of lines (need line numbers)
" Use Shift-v then press '#'.  Press '-#' to remove (with Shft-v)
vnoremap # :s#^#\##<cr>
vnoremap -# :s#^\###<cr>

" For rust files
call plug#begin('~/.vim/autoload')
Plug 'rust-lang/rust.vim'

"""""""""""""""""""""""""""""""
"""  VIM PLUGINS
"""""""""""""""""""""""""""""""
execute pathogen#infect()
filetype plugin indent on

set tabstop=4
set colorcolumn=110

set statusline=[%n]\ %f
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open =1
let g:syntastic_check_on_wq = 0


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
au BufRead,BufNewFile *py,*pyw*.c,*.h set tabstop=4

" What to use for an indent.  This will affect Ctl-T and
" 'autoindent'.  Python: 4 spaces
au BufRead,BufNewFile *.py,*pyw,*.pl,*.pm set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw,*.pl,*.pm set expandtab
fu Select_c_style()
	if search('^\t', 'n', 150)
		set shiftwidth=4
		set noexpandtab
	el
		set shiftwidth=4
		set expandtab
	en
endf
au BufRead,BufNewFile *.c,*.h,*.pl,*.pm call Select_c_style()
au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is
" desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw,*.pl,*.pm match BadWhitespace /^\t\+/

" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.pl,*.pm,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 79
" C: 79
au BufRead,BufNewFile *.py,*.pyw,*.pl,*.pm,*.c*.h set textwidth=79

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
au BufRead,BufNewFile *.c,*.h set formatoptions=-c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings
" Only used for new files so as to not force existing files to change
" their line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.pl,*.pm,*.c,*.h set fileformat=unix

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

" I gotsta have my syntax!
:syntax on

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

"===================================
" Mappings for editing my .vimrc
"===================================

:iab Vno "=======================================" "=======================================ka

"=======================================
"  HTML  HTML  HTML  HTML  HTML  HTML
"=======================================

:iab Hnew  <!DOCTYPE html><HTML><HEAD><META HTTP-EQUIV="Content-Type" CONTENT="text/html"; charset="utf-8"><META NAME="GENERATOR" CONTENT="VIM 5.0"><META NAME="Author" CONTENT="Dave Jackson <dsj@dsj.net>"><META NAME="Description" CONTENT="More of Dave Jackson's Drivel and Cruft."><TITLE></TITLE></HEAD><BODY TEXT="#000000" BGCOLOR="#FFFFFF" LINK="#0000EF" VLINK="#55188A" ALINK="#FF0000"><BR></BODY></HTML>?</TITLE>i

:iab Hbr <BR>
:iab H1 <H1></H1>4hi
:iab H2 <H2></H2>4hi
:iab H3 <H3></H3>4hi
:iab H4 <H4></H4>4hi
:iab H5 <H5></H5>4hi
:iab H6 <H6></H6>4hi
:iab H7 <H7></H7>4hi
:iab H8 <H8></H8>4hi

:iab Hul <UL><LI></LI></UL>k0/</h
:iab Hol <OL><LI></LI></OL>k0/</h
:iab Hli <LI></LI>4hi  
:iab Ha <a href=":r!cat /dev/ttykJx$a"></a>?</a>i
:iab Himg <IMG SRC="#">2h
:iab Hr <HR NOSHADE>
:iab Hem <EM></EM>?</EM>i

:iab Hp <P></P>?</P>i

:iab Hattrib gg/<\/BODY>i<BR><HR><FONT SIZE=-1><A HREF="http://www.dsj.net">David S. Jackson</A>Marietta, GA.<BR>k:r!sdA</FONT>

"==============================
"    C and C++ macros
"==============================
:iab Cii #include <iostream.h>
:iab Cis #include <stdlib.h>

"==============================
"   Vimspell external script
"==============================
noremap <F8> :so `/home/dsj/bin/vimspell %`:!/home/dsj/bin/vimspell % -r

colorscheme elflord
