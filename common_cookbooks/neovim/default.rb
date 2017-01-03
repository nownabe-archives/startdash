package "neovim"
package "python2-neovim"
package "python3-neovim"

remote_directory "#{home}/.config/nvim" do
  user default_user
  source "files/nvim"
end
