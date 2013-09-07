require './packages/gcc'
require 'json'
require 'pathname'

@device = JSON.parse(File.read('./device.json'), symbolize_names: true)
@device.each do |key, elem|
  @device[key] = @device[key].to_sym rescue @device[key]
end

Gcc.dependencies
