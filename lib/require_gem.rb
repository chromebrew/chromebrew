require_relative 'color'

def require_gem(ruby_gem_name_and_require = nil, require_override = nil)
  # Allow only loading gems when needed.
  return if ruby_gem_name_and_require.nil?

  ruby_gem_name = ruby_gem_name_and_require.split('/')[0]
  begin
    gem ruby_gem_name
  rescue LoadError
    puts " -> install #{ruby_gem_name} gem".orange
    Gem.install(ruby_gem_name)
    gem ruby_gem_name
  end
  requires = if require_override.nil?
               ruby_gem_name_and_require.split('/')[1].nil? ? ruby_gem_name_and_require.split('/')[0] : ruby_gem_name_and_require
             else
               require_override
             end
  require requires
end
