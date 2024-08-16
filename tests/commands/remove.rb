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

device_json = PackageUtils.load_json
essential_deps = device_json[:essential_deps]

class RemoveCommandTest < Minitest::Test
  def test_remove_essential_package
    puts "Essential depependency packages: #{essential_deps}."
    random_essential_package = essential_deps[rand(0...(essential_deps.length - 1))]

    expected_output = "#{random_essential_package.capitalize} is considered an essential package needed for"
    name = random_essential_package
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
      system "crew install #{name} &>/dev/null", out: File::NULL unless PackageUtils.installed?(name)
      Command.remove(pkg, true)
    end
  end
end
