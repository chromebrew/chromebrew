require 'minitest/autorun'
require_relative '../../lib/const'
require_relative '../../lib/docopt'

class DocoptParseTest < Minitest::Test
  def test_crew_with_docopt_flags
    expected_output = 'true'
    assert_output(expected_output, nil) do
      print Docopt.docopt(CREW_DOCOPT,  argv: '-d const ARCH' ).is_a?(Hash)
    end
  end
end
