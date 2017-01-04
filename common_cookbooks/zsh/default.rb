package "zsh"

directory "#{home}/.zsh.d" do
  owner default_user
  group default_user
end

remote_file "#{home}/.zshrc" do
  owner default_user
  group default_user
  source "files/zshrc"
end

execute "change shell" do
  command "usermod --shell `which zsh` #{default_user}"
  not_if "grep #{default_user} /etc/passwd | grep -q zsh"
end

remote_directory "#{home}/.zsh.d" do
  user default_user
  source "files/zsh.d"
end
