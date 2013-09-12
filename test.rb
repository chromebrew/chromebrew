#require './packages/buildessential'
require 'json'
require 'pathname'

@device = JSON.parse(File.read('./device.json'), symbolize_names: true)
@device.each do |key, elem|
  @device[key] = @device[key].to_sym rescue @device[key]
end

Dir.chdir './meta' do
  File.open("make.directorylist").each_line do |line|
    #puts line
    system "mkdir -p " + line.chomp
  end

  File.open("make.filelist").each_line do |line|
    Dir.chdir '../tmp' do
      system "mv", '.' + line.chomp, line.chomp
    end
  end
end
