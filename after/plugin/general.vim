" ctags configuration
let Tlist_php_settings = 'php;c:class,d:constant,f:function'
if exists('loaded_taglist')
	nnoremap <silent> <f6> :TlistToggle<cr>
endif
