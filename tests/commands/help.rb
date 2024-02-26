require 'minitest/autorun'
require_relative '../../commands/help'

class HelpCommandTest < Minitest::Test
  def test_no_arguments
    expected_output = <<~EOT
      Usage: crew help <command>
      Available commands: build, const, deps, download, files, help, install, list, postinstall, prop, reinstall, remove, search, sysinfo, update, upgrade, upload, whatprovides, license, version
    EOT
    assert_output expected_output, nil do
      Command.help(nil, nil)
    end
  end

  def test_const_command
    expected_output = <<~EOT
      Display constant(s).
      Usage: crew const [<const1> <const2> ...]
      If no constants are provided, all constants will be displayed.
    EOT
    assert_output expected_output, nil do
      Command.help('const', nil)
    end
  end

  def test_prop_command
    expected_output = "Use the 'is_static' property for packages which do not require shared dependencies.\n"
    assert_output expected_output, nil do
      Command.help('prop', 'is_static')
    end
  end
end
