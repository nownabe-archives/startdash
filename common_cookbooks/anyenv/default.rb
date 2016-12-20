package "git"

git "#{home}/.anyenv" do
  user username
  repository "https://github.com/riywo/anyenv"
end

remote_file "#{home}/.zsh.d/anyenv.sh" do
  owner username
  group username
  source "files/home/user/.zsh.d/anyenv.sh"
end

git "#{home}/.anyenv/plugins/anyenv-update" do
  user username
  repository "https://github.com/znz/anyenv-update.git"
end
