# Detect platform and define 'cookbook' method
backend =
  @variables[:node]
    .instance_variable_get(:@backend)
    .instance_variable_get(:@backend)

platform_name = backend.os_info[:family]
platform_version = backend.os_info[:release]
platform = "#{platform_name}-#{platform_version}"
platform_dir = File.expand_path("../platforms/#{platform}", __FILE__)

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

resource_names = %i(
  directory execute file gem_package git http_request
  link local_ruby_block package group user remote_directory
  remote_file service template
)

MItamae::RecipeContext.define_method(:include) do |mod|
  singleton_class.prepend(mod)

  patched_resources =
    resource_names.each_with_object({}) do |name, patched_resources|
      klass_name =
        case name
        when :http_request
          :HTTPRequest
        else
          name.to_s.gsub(/(^|_)(.)/) { $2.upcase }.to_sym
        end
      resource = ::MItamae::Resource.const_get(klass_name)

      patched_resource_context = Class.new(::MItamae::ResourceContext) { prepend(mod) }

      patched_resource = Class.new(resource)
      patched_resource.define_singleton_method(:to_s) { superclass.to_s }
      patched_resource.available_actions = resource.available_actions
      patched_resource.define_method(:initialize) do |resource_name, recipe, variables = {}, &block|
        @recipe = recipe
        @attributes = Hashie::Mash.new
        @resource_name = resource_name
        @verify_commands = []
        @notifications = []
        @subscriptions = []
        if block
          patched_resource_context.new(self, variables).instance_exec(&block)
        end
        process_attributes
        @attributes.freeze
      end
      patched_resources[name] = patched_resource
    end

  patched_resources.each do |name, patched_resource|
    singleton_class.define_method(name) do |arg1, &block|
      @recipe.children << patched_resource.new(arg1, @recipe, @variables, &block)
    end
  end
end

# Register aliases
user = ENV["SUDO_USER"]
home = platform =~ /darwin/i ? "/Users/#{user}" : "/home/#{user}"
bin  = File.join(home, "bin")
src  = File.join(home, "src")

MItamae::RecipeContext.define_method(:username) { user }
MItamae::RecipeContext.define_method(:default_user) { user }
MItamae::RecipeContext.define_method(:home)     { home }
MItamae::RecipeContext.define_method(:bin)      { bin }
MItamae::RecipeContext.define_method(:src)      { src }

MItamae::ResourceContext.define_method(:username) { user }
MItamae::ResourceContext.define_method(:default_user) { user }
MItamae::ResourceContext.define_method(:home)     { home }
MItamae::ResourceContext.define_method(:bin)      { bin }
MItamae::ResourceContext.define_method(:src)      { src }

# Run recipe
MItamae.logger.info "Current Platform: #{platform}"

include_recipe "recipe"
include_recipe File.join(platform_dir, "recipe")
