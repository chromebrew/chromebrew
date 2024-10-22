require 'minitest/autorun'
require_relative '../../commands/list'
require_relative '../../lib/convenience_functions'

# Add lib to LOAD_PATH
$LOAD_PATH << File.join(CREW_LIB_PATH, 'lib')

String.use_color = false

class ListCommandTest < Minitest::Test
  def setup
    @essential_deps = ConvenienceFunctions.load_symbolized_json[:essential_deps].join("\n") + "\n".to_s
  end

  def test_list_essential_deps
    expected_output = @essential_deps
    assert_output(expected_output, nil) do
      # Command.list(args['available'], args['compatible'], args['incompatible'], args['essential'], args['installed'], CREW_VERBOSE)
      Command.list(false, false, false, true, false, false)
    end
  end
end
