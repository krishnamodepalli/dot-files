" $VIMRUNTIME/indent/php.vim only indents actual PHP code: for any line
" outside a `<?php ... ?>` block (i.e. plain HTML template markup) it
" returns -1 ("leave the indent alone"), so mixed PHP/HTML files never get
" the embedded HTML indented. Layer the HTML indenter as a fallback for
" those lines, keeping GetPhpIndent() for everything else.
"
" This must live in after/indent/ (not after/ftplugin/): indent scripts are
" sourced as their own runtime pass, after ftplugin/php.vim and any
" after/ftplugin/php.vim, so only after/indent/php.vim runs late enough to
" see -- and override -- indent/php.vim's indentexpr.
if exists('b:php_html_indent_loaded')
  finish
endif
let b:php_html_indent_loaded = 1

let s:php_indentexpr = &l:indentexpr
let s:php_indentkeys = &l:indentkeys

" indent/html.vim bails out immediately if b:did_indent is already set
" (php's indent script sets it), so clear it just long enough to source
" HtmlIndent() and its helpers, then restore php's indentexpr/indentkeys.
unlet! b:did_indent
runtime! indent/html.vim
let b:did_indent = 1

let &l:indentexpr = s:php_indentexpr
let &l:indentkeys = s:php_indentkeys . ',<>>'

function! PhpHtmlIndent() abort
  let l:ind = eval(s:php_indentexpr)
  if l:ind == -1
    return HtmlIndent()
  endif
  return l:ind
endfunction

setlocal indentexpr=PhpHtmlIndent()
