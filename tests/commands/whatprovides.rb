require 'minitest/autorun'
require_relative '../../commands/whatprovides'

# Add lib to LOAD_PATH
$LOAD_PATH << File.join(CREW_LIB_PATH, 'lib')

String.use_color = false

class WhatprovidesCommandTest < Minitest::Test
  def test_whatprovides
    expected_output = <<~TEST_EOF
      crew_profile_base: /usr/local/etc/profile

      Total found: 1
    TEST_EOF
    assert_output(expected_output, nil) do
      # Command.whatprovides(regex)
      Command.whatprovides('/usr/local/etc/profile$')
    end
  end
end
