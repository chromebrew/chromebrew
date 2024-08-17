require 'minitest/autorun'
require_relative '../../commands/remove'
require_relative '../../lib/package_utils'

# Add lib to LOAD_PATH
$LOAD_PATH << File.join(CREW_LIB_PATH, 'lib')

# This is needed to force --no-color mode.
String.use_color = false

class RemoveCommandTest < Minitest::Test
  def setup
    essential_deps = PackageUtils.load_json[:essential_deps]
    @random_essential_package_name = essential_deps[rand(0...(essential_deps.length - 1))]
    puts <<~ESSENTIAL_PACKAGE_REMOVAL_TEST_EOF

      Testing the removal of essential package #{@random_essential_package_name}, which was picked at random from one the essential packages: #{essential_deps.join(', ')}
      (This should fail.)

    ESSENTIAL_PACKAGE_REMOVAL_TEST_EOF
    @random_essential_pkg = Package.load_package("#{@random_essential_package_name}.rb")

    @normal_package_name = 'xxd_standalone'
    puts <<~NORMAL_PACKAGE_REMOVAL_TEST_EOF

      Testing the removal of normal package #{@normal_package_name}.
      (This should succeed.)

    NORMAL_PACKAGE_REMOVAL_TEST_EOF
    @normal_pkg = Package.load_package("#{@normal_package_name}.rb")
  end

  def test_remove_essential_package
    # expected_output = %(  #{@random_essential_package_name.capitalize} is considered an essential package needed for
    # Chromebrew to function and thus cannot be removed.
    # )
    # assert_output(expected_output, nil) do
    # Command.remove(@random_essential_pkg, true)
    # end

    assert_raises(SystemExit) { Command.remove(@random_essential_pkg, true) }
  end

  def test_remove_normal_package
    expected_output = <<~EOT
      #{@normal_package_name} removed
    EOT
    assert_output(/^#{Regexp.escape(expected_output.chomp)}!/, nil) do
      until PackageUtils.installed?(@normal_package_name)
        system "crew install -d #{@normal_package_name} &>/dev/null", out: File::NULL
        sleep 2
      end
      Command.remove(@normal_pkg, true)
    end
  end
end
