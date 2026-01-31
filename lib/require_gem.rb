require_relative 'color'
require_relative 'const'

def require_gem(ruby_gem_name_and_require = nil, require_override = nil)
  # Allow only loading gems when needed.
  return if ruby_gem_name_and_require.nil?

  ruby_gem_name = ruby_gem_name_and_require.split('/')[0]
  begin
    gem ruby_gem_name
  rescue NoMethodError, Gem::MissingSpecError
    # Handle possible error immediately after a gem uninstall.
    # e.g.,
    # Gem::Specification#activate_dependencies': Could not find 'rubocop' (>= 0) among 150 total gem(s) (Gem::MissingSpecError)
    require 'rubygems/gem_runner'
    Gem::GemRunner.new.run %w[check doctor #{ruby_gem_name}]
    Gem::GemRunner.new.run ['sources', '-u']
    puts " -> install #{ruby_gem_name} gem".orange CREW_OUTPUT_JSON if CREW_VERBOSE && !CREW_OUTPUT_JSON
    system "gem install #{ruby_gem_name} -N #{'--silent -q' unless CREW_VERBOSE && !CREW_OUTPUT_JSON}"
    gem ruby_gem_name
  rescue LoadError
    puts " -> install #{ruby_gem_name} gem".orange if CREW_VERBOSE && !CREW_OUTPUT_JSON
    system "gem install #{ruby_gem_name} -N #{'--silent -q' unless CREW_VERBOSE && !CREW_OUTPUT_JSON}"
    gem ruby_gem_name
  end
  requires = if require_override.nil?
               ruby_gem_name_and_require.split('/')[1].nil? ? ruby_gem_name_and_require.split('/')[0] : ruby_gem_name_and_require
             else
               require_override
             end
  require requires
end
