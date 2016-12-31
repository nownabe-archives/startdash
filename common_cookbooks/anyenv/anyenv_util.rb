module AnyenvUtil
  def anyenv_root
    "#{home}/.anyenv"
  end

  def anyenv_path
    "#{anyenv_root}/bin"
  end

  def anyenv_shims
    "#{anyenv_root}/shims"
  end

  def init_command
    "eval \"$(#{anyenv_path}/anyenv init -)\""
  end

  def anyenv(command)
    "#{init_command} && #{anyenv_path}/anyenv #{command}"
  end

  def anyenv_command(command)
    "#{init_command} && #{command}"
  end
end
