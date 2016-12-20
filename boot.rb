# Detect platform and define 'cookbook' method
backend =
  @variables[:node]
    .instance_variable_get(:@backend)
    .instance_variable_get(:@backend)

platform = backend.os_info[:family]
platform_version = backend.os_info[:release]
platform_dir = File.expand_path("../platforms/#{platform}-#{platform_version}", __FILE__)

MItamae::RecipeContext.define_method(:cookbook) do |name|
  if ENV["COOKBOOK"] && ENV["COOKBOOK"] != name
    MItamae.logger.info "Skip #{name} cookbook"
    return
  end
  MItamae.logger.info "Execute #{name} cookbook"
  platform_cookbook =
    File.join(platform_dir, "cookbooks", name)
  common_cookbook =
    File.join(File.expand_path("../common_cookbooks", __FILE__), name)

  if File.directory?(platform_cookbook)
    include_recipe(platform_cookbook)
  elsif File.directory?(common_cookbook)
    include_recipe(common_cookbook)
  else
    include_recipe(name)
  end
end

# Register aliases
user = ENV["SUDO_USER"]
home = platform =~ /darwin/i ? "/Users/#{user}" : "/home/#{user}"
bin  = File.join(home, "bin")
src  = File.join(home, "src")

MItamae::RecipeContext.define_method(:username) { user }
MItamae::RecipeContext.define_method(:home)     { home }
MItamae::RecipeContext.define_method(:bin)      { bin }
MItamae::RecipeContext.define_method(:src)      { src }

MItamae::ResourceContext.define_method(:username) { user }
MItamae::ResourceContext.define_method(:home)     { home }
MItamae::ResourceContext.define_method(:bin)      { bin }
MItamae::ResourceContext.define_method(:src)      { src }

# Run recipe
MItamae.logger.info "Current Platform: #{platform} #{platform_version}"

include_recipe "recipe"
