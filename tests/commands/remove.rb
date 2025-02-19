require 'minitest/autorun'
require_relative '../../commands/remove'
require_relative '../../lib/const'

# Add lib to LOAD_PATH
$LOAD_PATH << File.join(CREW_LIB_PATH, 'lib')

# This is needed to force --no-color mode.
String.use_color = false

class RemoveCommandTest < Minitest::Test
  def test_remove_essential_package
    random_essential_package = CREW_ESSENTIAL_PACKAGES.sample
    puts "Testing the removal of essential package #{random_essential_package}, which was picked at random from one of the essential packages: #{CREW_ESSENTIAL_PACKAGES.join(', ')}. This should fail."

    assert_raises(SystemExit) do
      # We don't want the output of this command, so we just capture it here and ignore it.
      capture_io { Command.remove(Package.load_package("#{random_essential_package}.rb"), false) }
    end
  end

  def test_remove_package_with_essential_file
    essential_file = File.join(CREW_LIB_PREFIX, 'libstdc++.so.6')
    puts "Testing the removal of package gcc_build. This should succeed, but essential file #{essential_file} should not be removed."

    system 'crew install gcc_build', %i[out err] => File::NULL
    capture_io { Command.remove(Package.load_package('gcc_build.rb'), false) }
    assert File.file?(essential_file), nil
  end

  def test_remove_normal_package
    puts 'Testing the removal of normal package xxd_standalone. This should succeed.'

    expected_output = "xxd_standalone removed!\n"
    assert_output expected_output, nil do
      system 'crew install xxd_standalone', %i[out err] => File::NULL
      Command.remove(Package.load_package('xxd_standalone.rb'), false)
    end
  end
end
