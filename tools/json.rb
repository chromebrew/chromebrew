require 'json'

# Add >LOCAL< lib to LOAD_PATH
$LOAD_PATH.unshift '../lib'

require_relative '../lib/const'
require_relative '../lib/package'
require_relative '../lib/package_utils'

def require_gem(gem_name_and_require = nil, require_override = nil)
  # Allow only loading gems when needed.
  return if gem_name_and_require.nil?

  gem_name = gem_name_and_require.split('/')[0]
  begin
    gem gem_name
  rescue LoadError
    puts " -> install #{gem_name} gem".orange
    Gem.install(gem_name)
    gem gem_name
  end
  requires = if require_override.nil?
               gem_name_and_require.split('/')[1].nil? ? gem_name_and_require.split('/')[0] : gem_name_and_require
             else
               require_override
             end
  require requires
end
require_gem('activesupport', 'active_support/core_ext/object/blank')
require_gem('ptools')

output = []

Dir.glob('../packages/*.rb').each do |filename|
  # docbook_xml runs code on loading that does not work when chromebrew is not installed.
  # It shouldn't be doing that, but work around it for now.
  next if filename.include?('docbook')
  pkg = Package.load_package(filename)
  # Skip fake or prerelease packages.
  next if pkg.is_fake? || pkg.prerelease?
  output << { name: File.basename(filename, '.rb'), description: pkg.description, homepage: pkg.homepage, version: PackageUtils.get_clean_version(+pkg.version), license: pkg.license, compatibility: pkg.compatibility }
end

File.write('repology.json', JSON.pretty_generate(output))
