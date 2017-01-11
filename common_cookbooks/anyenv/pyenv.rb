include AnyenvUtil

version="3.6.0"

execute "Install pyenv" do
  user default_user
  command anyenv("install pyenv")
  not_if "#{anyenv('versions')} | grep -q pyenv"
end

execute "Install Python #{version}" do
  user default_user
  command anyenv_command("pyenv install #{version}")
  not_if "#{anyenv_command('pyenv versions')} | grep -q #{version}"
  notifies :run, "execute[Enable Python #{version}]", :immediately
end

execute "Enable Python #{version}" do
  action :nothing
  user default_user
  command anyenv_command("pyenv global #{version}")
end
