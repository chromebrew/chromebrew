require 'minitest/autorun'
require_relative '../../commands/const'

class ConstCommandTest < Minitest::Test
  def test_no_arguments
    expected_output = 'CREW_FNO_LTO_LDFLAGS=-fno-lto'
    assert_output(/#{Regexp.escape(expected_output)}/, nil) do
      Command.const(nil)
    end
  end

  def test_valid_constant
    expected_output = "CREW_FNO_LTO_LDFLAGS=-fno-lto\n"
    assert_output expected_output, nil do
      Command.const('CREW_FNO_LTO_LDFLAGS')
    end
  end

  def test_invalid_constant
    expected_output = "Constant INVALID not found\n"
    assert_output expected_output, nil do
      Command.const('INVALID')
    end
  end
end
