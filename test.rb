require './packages/buildessential'
require 'json'
require 'pathname'

@device = JSON.parse(File.read('./device.json'), symbolize_names: true)
@device.each do |key, elem|
  @device[key] = @device[key].to_sym rescue @device[key]
end

@device[:installed_packages].any? { |pkg| pkg[:name] == 'gcc' }
