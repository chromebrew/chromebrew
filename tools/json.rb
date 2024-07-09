require 'json'

# Add >LOCAL< lib to LOAD_PATH
$LOAD_PATH.unshift '../lib'

require_relative '../lib/const'
require_relative '../lib/package'

output = []

Dir.glob('../packages/*.rb').each do |filename|
  # docbook_xml runs code on loading that does not work when chromebrew is not installed.
  # It shouldn't be doing that, but work around it for now.
  next if filename.include?('docbook')
  pkg = Package.load_package(filename)
  # Skip fake packages.
  next if pkg.is_fake?
  # Present a useful version to Repology.
  version = +pkg.version
  # That starts by trimming off our language version tagging.
  version.delete_suffix!('-py3.12')
  version.delete_suffix!('-perl5.40')
  version.delete_suffix!('-llvm18')
  version.delete_suffix!("-glibc#{LIBC_VERSION}")
  output << { name: File.basename(filename, '.rb'), description: pkg.description, homepage: pkg.homepage, version:, license: pkg.license, compatibility: pkg.compatibility }
end

File.write('repology.json', JSON.pretty_generate(output))
