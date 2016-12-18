backend =
  @variables[:node]
    .instance_variable_get(:@backend)
    .instance_variable_get(:@backend)

platform = backend.os_info[:family]
platform_version = backend.os_info[:release]
platform_dir = File.expand_path("../platforms/#{platform}-#{platform_version}", __FILE__)
common_dir = 

MItamae::RecipeContext.define_method(:cookbook) do |name|
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

MItamae.logger.info "Current Platform: #{platform} #{platform_version}"

cookbook "chrome"
cookbook "anyenv"

