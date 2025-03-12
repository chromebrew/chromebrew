require 'minitest/autorun'
require_relative '../../commands/list'
require_relative '../../lib/const'

# Add lib to LOAD_PATH
$LOAD_PATH << File.join(CREW_LIB_PATH, 'lib')

String.use_color = false

class ListCommandTest < Minitest::Test
  def test_list_essential_packages
    expected_output = "#{CREW_ESSENTIAL_PACKAGES.join("\n")}\n"
    assert_output(expected_output, nil) do
      # Command.list(args['available'], args['compatible'], args['incompatible'], args['essential'], args['installed'], CREW_VERBOSE)
      Command.list(false, false, false, true, false, false)
    end
  end
end
