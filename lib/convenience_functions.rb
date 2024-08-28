# lib/convenience_functions.rb
# Extracted bits of crew-specific code that we use frequently enough that it makes sense to split them out to here.
require 'json'
require_relative 'const'
require_relative 'crewlog'

class ConvenienceFunctions
  def self.load_symbolized_json
    return JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'), symbolize_names: true).transform_values! { |val| val.is_a?(String) ? val.to_sym : val }
  end

  def self.load_json
    return JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'))
  end

  def self.save_json(json_object)
    crewlog 'Saving device.json...'
    begin
      File.write File.join(CREW_CONFIG_PATH, 'device.json.tmp'), JSON.pretty_generate(JSON.parse(json_object.to_json))
    rescue StandardError
      puts 'Error writing updated packages json file!'.lightred
      abort
    end

    # Copy over original if the write to the tmp file succeeds.
    FileUtils.cp("#{CREW_CONFIG_PATH}/device.json.tmp", File.join(CREW_CONFIG_PATH, 'device.json')) && FileUtils.rm("#{CREW_CONFIG_PATH}/device.json.tmp")
  end
end
