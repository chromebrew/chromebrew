require 'minitest/autorun'
require_relative '../../commands/remove'
require_relative '../../lib/const'
require_relative '../../lib/package_utils'

# Add lib to LOAD_PATH
$LOAD_PATH << File.join(CREW_LIB_PATH, 'lib')

# This is needed to force --no-color mode.
String.use_color = false

class RemoveCommandTest < Minitest::Test
  def setup
    @random_essential_package_name = CREW_ESSENTIAL_PACKAGES.sample
    puts <<~ESSENTIAL_PACKAGE_REMOVAL_TEST_EOF

      Testing the removal of essential package #{@random_essential_package_name}, which was picked at random from one the essential packages: #{CREW_ESSENTIAL_PACKAGES.join(', ')}
      (This should fail.)

    ESSENTIAL_PACKAGE_REMOVAL_TEST_EOF
    @random_essential_pkg = Package.load_package("#{@random_essential_package_name}.rb")

    @package_with_essential_file = 'gcc_build'
    @essential_file = File.join(CREW_LIB_PREFIX, 'libstdc++.so.6')
    puts <<~PACKAGE_WITH_ESSENTIAL_FILE_REMOVAL_TEST_EOF

      Testing the removal of package #{@package_with_essential_file}.
      (This should succeed, but essential file #{@essential_file}
      should not be removed.)

    PACKAGE_WITH_ESSENTIAL_FILE_REMOVAL_TEST_EOF

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

  def test_remove_package_with_essential_file
    assert_output(true) do
      until PackageUtils.installed?(@package_with_essential_file)
        system "crew install -d #{@package_with_essential_file}", %i[out err] => File::NULL
        sleep 2
      end
      system "crew remove -d #{@package_with_essential_file}", %i[out err] => File::NULL
      return File.file?(@essential_file)
    end
  end

  def test_remove_normal_package
    expected_output = <<~EOT
      #{@normal_package_name} removed
    EOT
    assert_output(/^#{Regexp.escape(expected_output.chomp)}!/, nil) do
      until PackageUtils.installed?(@normal_package_name)
        system "crew install -d #{@normal_package_name}", %i[out err] => File::NULL
        sleep 2
      end
      Command.remove(@normal_pkg, true)
    end
  end
end
