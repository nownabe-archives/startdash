include AnyenvUtil

version = "2.4.0"
default_gems = %w(
  bundler
  pry
)

%w(
  gcc bzip2 openssl-devel libyaml-devel libffi-devel
  readline-devel zlib-devel gdbm-devel ncurses-devel
).each { |pkg| package pkg }

execute "Install rbenv" do
  user username
  command anyenv("install rbenv")
  not_if "#{anyenv('versions')} | grep -q rbenv"
end

execute "Install Ruby #{version}" do
  user username
  command anyenv_command("rbenv install #{version}")
  not_if "#{anyenv_command('rbenv versions')} | grep -q #{version}"
  notifies :run, "execute[Enable Ruby #{version}]", :immediately
end

execute "Enable Ruby #{version}" do
  action :nothing
  user username
  command anyenv_command("rbenv global #{version}")
end

default_gems.each do |gem|
  gem_package gem do
    user username
    gem_binary "#{anyenv_root}/envs/rbenv/shims/gem"
  end
end
