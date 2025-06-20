require 'json'

# Add >LOCAL< lib to LOAD_PATH
$LOAD_PATH.unshift '../lib'

require_relative '../lib/const'
require_relative '../lib/package'
require_relative '../lib/package_utils'
require_relative '../lib/require_gem'

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
