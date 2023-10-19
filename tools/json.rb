require 'json'

# Add >LOCAL< lib to LOAD_PATH
$LOAD_PATH.unshift '../lib'

require_relative '../lib/const'
require_relative '../lib/package'

output = Array.new

Dir.glob('../packages/*.rb').each do |filename|
  pkg = Package.load_package(filename)
  next if pkg.is_fake?
  output << {name: File.basename(filename, '.rb').gsub("_","-"), description: pkg.description, homepage: pkg.homepage, version: pkg.version, license: pkg.license, compatibility: pkg.compatibility}
end

File.write('repology.json', JSON.generate(output))
