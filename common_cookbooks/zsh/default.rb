package "zsh"

directory "#{home}/.zsh.d" do
  owner username
  group username
end

remote_file "#{home}/.zshrc" do
  owner username
  group username
  source "files/home/user/.zshrc"
end

execute "change shell" do
  command "usermod --shell `which zsh` #{username}"
  not_if "grep #{username} /etc/passwd | grep -q zsh"
end
