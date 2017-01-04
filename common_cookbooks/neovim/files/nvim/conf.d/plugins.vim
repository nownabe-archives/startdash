" Plugins
" Managed by vim-plug

call plug#begin('~/.config/share/nvim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-ruby/vim-ruby'

call plug#end()

" Auto Installation

let s:plug = {
\ "plugs": get(g:, 'plugs', {})
\ }

function! s:plug.check_installation()
  if empty(self.plugs)
    return
  endif

  let list = []
  for [name, spec] in items(self.plugs)
    if !isdirectory(spec.dir)
      call add(list, spec.uri)
    endif
  endfor

  if len(list) > 0
    let unplugged = map(list, 'substitute(v:val, "^.*github\.com/\\(.*/.*\\)\.git$", "\\1", "g")')
    echomsg 'Not installed plugs: ' . string(unplugged)
    if confirm('Install plugs now?', "yes\nNo", 2) == 1
      PlugInstall
    endif
  endif
endfunction

augroup check-plug
  autocmd!
  autocmd VimEnter * call s:plug.check_installation()
augroup END
