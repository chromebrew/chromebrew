require 'minitest/autorun'
require 'json'
require_relative '../../commands/remove'
require_relative '../../commands/search'
require_relative '../../lib/const'
require_relative '../../lib/package'
require_relative '../../lib/package_utils'

# Add lib to LOAD_PATH
$LOAD_PATH << File.join(CREW_LIB_PATH, 'lib')

String.use_color = false

def load_json
  # load_json(): (re)load device.json
  json_path = File.join(CREW_CONFIG_PATH, 'device.json')
  @device   = JSON.load_file(json_path, symbolize_names: true)

  # symbolize also values
  @device.transform_values! { |val| val.is_a?(String) ? val.to_sym : val }
end

def save_json(json_object)
  crewlog 'Saving device.json...'
  begin
    File.write File.join(CREW_CONFIG_PATH, 'device.json.tmp'), JSON.pretty_generate(JSON.parse(json_object.to_json))
  rescue StandardError
    puts 'Error writing updated packages json file!'.lightred
    abort
  end

  # Copy over original if the write to the tmp file succeeds.
  FileUtils.cp("#{CREW_CONFIG_PATH}/device.json.tmp", File.join(CREW_CONFIG_PATH, 'device.json')) && FileUtils.rm("#{CREW_CONFIG_PATH}/device.json.tmp")
  load_json
end

class RemoveCommandTest < Minitest::Test
  def test_remove_essential_package
    essential_deps = Package.essential_recursive_deps
    puts "Essential deps have been determined to be #{essential_deps}."
    @random_essential_package = essential_deps[rand(0...(essential_deps.length - 1))]

    expected_output = "#{@random_essential_package.capitalize} is considered an essential package needed for."
    name = @random_essential_package
    pkg = Package.load_package("#{name}.rb")
    puts "Testing removal of essential package #{name}, which SHOULD fail."
    assert_output(/^#{Regexp.escape(expected_output.chomp)}!/, nil) do
      Command.remove(pkg, true)
    end
  end

  def test_remove_normal_package
    name = 'xxd_standalone'
    pkg = Package.load_package("#{name}.rb")
    expected_output = <<~EOT
      #{name} removed
    EOT
    assert_output(/^#{Regexp.escape(expected_output.chomp)}!/, nil) do
      system "crew install #{name} &>/dev/null", out: File::NULL
      Command.remove(pkg, true)
    end
  end
end
