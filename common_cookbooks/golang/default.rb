package "golang"

remote_file "#{home}/.zsh.d/golang.sh" do
  owner default_user
  group default_user
  source "files/home/zsh.d/golang.sh"
end
