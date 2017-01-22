execute "Install ghq" do
  user default_user
  command "GOPATH=#{home} go get github.com/motemen/ghq"
  not_if "type ghq"
end

execute "Configure ghq.root" do
  user default_user
  command "git config --global ghq.root #{home}/src"
  not_if "git config --global ghq.root"
end
