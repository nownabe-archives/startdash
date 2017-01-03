for file in split(expand("~/.config/nvim/conf.d/*.vim"), "\n")
  execute "source " . file
endfor
