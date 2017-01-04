execute "Enable zsh-completions repository" do
  command "dnf copr enable -y nicoulaj/zsh-completions"
  not_if "rpm -q zsh-completions"
end

package "zsh-completions"
