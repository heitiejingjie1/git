"
"基础设置
 set nocompatible
 syntax on
 set showmode
 set showcmd
 set encoding=utf-8
 set t_Co=256
 filetype indent on
 set softtabstop=4
 set tabstop=4
 set shiftwidth=4
 set expandtab
 set autoindent
 set number
 set cursorline
 filetype plugin indent on 

" plugin
 call plug#begin()

 " vim颜色主题
 Plug 'tomasiser/vim-code-dark'
 " coc系列
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 " 括号补全
 Plug 'jiangmiao/auto-pairs'
 "clang代码格式化
 Plug 'rhysd/vim-clang-format'
 " vim-vsnip
 Plug 'hrsh7th/vim-vsnip'
 Plug 'hrsh7th/vim-vsnip-integ'
 " rust 语法高亮，格式化
 Plug 'rust-lang/rust.vim'
" rust代码补全
 Plug 'prabirshrestha/vim-lsp'
" 异步语法检查和代码格式化
 Plug 'dense-analysis/ale'
" 状态栏美化
 Plug 'vim-airline/vim-airline'

 call plug#end()



 " vim颜色主题设置
 colorscheme codedark

 " clang 代码格式化
  let g:clang_format#code_style='WebKit'
  nnoremap <C-A-i> :ClangFormat<CR>

" rust.vim 设置 
  let g:rustfmt_autosave = 1 " 保存时自动格式化
  let g:rustfmt_command = "rustfmt" " 自定义格式化命令

" ale 异步语法检查设置
  let g:ale_linters = {'rust': ['cargo', 'clippy'],}
  let g:ale_fixers = {'rust': ['cargo', 'rustfmt'],}
  let g:ale_rust_cargo_use_clippy = 1 

" airline 底边栏设置
" 设置显示ale语法检查结果
  let g:airline#extensions#ale#enabled = 1 

" 设置nerdtree
  " autocmd vimenter * NERDTree " 编辑文件时默认打开NERDTree
  " let g:NERDTreeShowHidden = 1 " 显示隐藏文件

" ========== Coc 设置==================
  " 使用制表符触发补全
  inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " 使用ctrl键选定所选项
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]=~# '\s'
  endfunction

  " 使用空格键选择所选项
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " 使用[g 和]g来导航诊断
  " 使用:CocDiagnostics来获取缓存中的诊断列表
 nmap <silent> [g <Plug>(coc-diagnostic-prev)
 nmap <silent> ]g <Plug>(coc-diagnostic-next)

 " 使用gd来获取定义
 " 使用gy来获取类型定义
 " 使用gi来获取代码实现
 " 使用gr来获取引用
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

 " 使用K 显示预览文档
nnoremap <silent> K :call ShowDocumentation()<CR>
 function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
 endif
 endfunction

  " 按住光标高亮显示字符和其引用
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " 使用rn重命名
nmap <leader>rn <Plug>(coc-rename)

  " 使用f键格式化选定代码
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
"
augroup mygroup
 autocmd!
 " 设置formatexpr指定的文件类型
 autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

  " 更新跳转占位符的签名帮助
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" 将代码动作运用于选定的代码块
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

"在光标位置重新映射用于应用代码操作的键
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" 应用代码操作的重映射键影响整个缓冲区
nmap <leader>as  <Plug>(coc-codeaction-source)
" 应用最喜欢的快速修复操作来修复当前行的诊断
nmap <leader>qf  <Plug>(coc-fix-current)

"重新映射用于应用重构代码操作的键
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" 在当前行上运用代码镜头
nmap <leader>cl  <Plug>(coc-codelens-action)

" 映射函数和类文本
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" 重新映射滚动浮窗弹出框
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" 使用Ctrl+S选择范围
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" 增加:format命令格式化当前缓冲区
command! -nargs=0 Format :call CocActionAsync('format')
" 使用:fold命令来折叠当前缓冲区
 command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" 使用:OR命令来组织当前缓冲区的使用
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" 添加(NEO)vim原生状态线支持
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"== coc命令列表
" 显示所有诊断
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" 管理扩展
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" 显示所有命令
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" 查找当前文档的符号
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" 搜索工作区符号
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" 对下一项执行默认操作
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" 对前一项执行默认操作
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" 恢复最近的coc列表
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"
