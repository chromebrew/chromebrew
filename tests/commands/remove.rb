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
      capture_io { Command.remove(Package.load_package("#{random_essential_package}.rb")) }
    end
  end

  # We've chosen zstd here because its an essential package we can remove and quickly reinstall without breaking crew.
  # If this changes, and there isn't an essential package we can remove without catastrophic failure, feel free to remove this test entirely.
  def test_force_remove_essential_package
    puts 'Testing the forced removal of essential package zstd. This should succeed.'

    expected_output = "zstd removed!\n"
    assert_output expected_output, nil do
      Command.remove(Package.load_package('zstd.rb'), force: true)
    end
    # We did just remove an essential package, so let's reinstall that now before it causes any issues.
    system 'crew install zstd', %i[out err] => File::NULL
  end

  def test_remove_package_with_essential_file
    essential_file = File.join(CREW_LIB_PREFIX, 'libstdc++.so.6')
    puts "Testing the removal of package gcc_build. This should succeed, but essential file #{essential_file} should not be removed."

    system 'crew install gcc_build', %i[out err] => File::NULL
    capture_io { Command.remove(Package.load_package('gcc_build.rb')) }
    assert File.file?(essential_file), nil
  end

  def test_remove_normal_package
    puts 'Testing the removal of normal package xxd_standalone. This should succeed.'

    expected_output = "xxd_standalone removed!\n"
    assert_output expected_output, nil do
      system 'crew install xxd_standalone', %i[out err] => File::NULL
      Command.remove(Package.load_package('xxd_standalone.rb'))
    end
  end

  def test_verbosely_remove_normal_package
    puts 'Testing the verbose removal of normal package xxd_standalone. This should succeed.'

    expected_output = <<~EOT
      Removing file #{CREW_PREFIX}/bin/xxd
      Removing file #{CREW_PREFIX}/share/man/man1/xxd.1.zst
      Removing package xxd_standalone from device.json
      xxd_standalone removed!
    EOT
    assert_output expected_output, nil do
      system 'crew install xxd_standalone', %i[out err] => File::NULL
      Command.remove(Package.load_package('xxd_standalone.rb'), verbose: true)
    end
  end
end
