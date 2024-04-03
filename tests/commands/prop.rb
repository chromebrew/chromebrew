require 'minitest/autorun'
require_relative '../../commands/prop'
require_relative '../../lib/package'

class PropCommandTest < Minitest::Test
  def test_no_arguments
    expected_output = <<~EOT
      Explain the purpose of various package boolean properties.
      Usage: crew prop <property>
      Available properties: #{Package.print_boolean_properties}
    EOT
    assert_output expected_output, nil do
      Command.prop(nil)
    end
  end

  def test_no_env_options_property
    expected_output = <<~EOT
      Use the 'no_env_options' property for packages that do not require
      environment options or to override the default options.
    EOT
    assert_output expected_output, nil do
      Command.prop('no_env_options')
    end
  end

  def test_is_static_property
    expected_output = "Use the 'is_static' property for packages which do not require shared dependencies.\n"
    assert_output expected_output, nil do
      Command.prop('is_static')
    end
  end
end
