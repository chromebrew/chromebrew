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

class RemoveCommandTest < Minitest::Test
  def test_remove_essential_package
    device_json = PackageUtils.load_json
    essential_deps = device_json[:essential_deps]
    puts "\nEssential depependency packages: #{essential_deps}."
    random_essential_package = essential_deps[rand(0...(essential_deps.length - 1))]

    expected_output = %(  #{random_essential_package.capitalize} is considered an essential package needed for
  Chromebrew to function and thus cannot be removed.
)
    name = random_essential_package
    pkg = Package.load_package("#{name}.rb")
    puts "Testing the removal of essential package #{name}, which was picked at random, which SHOULD fail."
    assert_output(expected_output, nil) do
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
      until device_json = PackageUtils.load_json && PackageUtils.installed?(name)
        system "crew install -d #{name} &>/dev/null", out: File::NULL
      end
      Command.remove(pkg, true)
    end
  end
end
