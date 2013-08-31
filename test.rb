require './packages/binutils'
require 'json'

@device = JSON.parse(File.read('./device.json'), symbolize_names: true)
@device.each do |key, elem|
  @device[key] = @device[key].to_sym rescue @device[key]
end

Binutils.version
Binutils.binary_url[@device[:architecture]]
Binutils.binary_sha1[:i686]
