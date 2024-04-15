require 'minitest/autorun'
require_relative '../../commands/help'
require_relative '../../lib/package'

class HelpCommandTest < Minitest::Test
  def test_no_arguments
    expected_output = <<~EOT
      Usage: crew help <command>
      Available commands: #{CREW_COMMANDS}
    EOT
    assert_output expected_output, nil do
      Command.help(nil)
    end
  end

  def test_prop_command
    expected_output = <<~EOT
      Explain the purpose of various package boolean properties.
      Usage: crew prop <property>
      Available properties: #{Package.print_boolean_properties}
    EOT
    assert_output expected_output, nil do
      Command.help('prop')
    end
  end

  def test_const_command
    expected_output = <<~EOT
      Display constant(s).
      Usage: crew const [<const1> <const2> ...]
      If no constants are provided, all constants will be displayed.
    EOT
    assert_output expected_output, nil do
      Command.help('const')
    end
  end
end
