require 'minitest/autorun'
require_relative '../../lib/color'
# We have to set these environment variables before requiring tools/build_updated_packages.rb, as otherwise it will abort because they are missing.
ENV['GITLAB_TOKEN'] = ''
ENV['GITLAB_TOKEN_USERNAME'] = ''
require_relative '../../tools/build_updated_packages'

# This is needed to force --no-color mode.
String.use_color = false

class BuildUpdatedPackagesTest < Minitest::Test
  # To avoid having to update these tests frequently, the only packages currently tested are those tagged with no_upstream_update.
  def test_multiple_dependencies
    expected_output = '{:js78=>[:nss], :nss=>[:gcc_lib, :glibc, :sqlite, :zlib], :gcc_lib=>[:glibc], :glibc=>[:crew_preload], :crew_preload=>[], :sqlite=>[:gcc_lib], :zlib=>[:glibc]}
crew_preload
glibc
gcc_lib
sqlite
zlib
nss
js78
'
    assert_output(expected_output, nil) do
      print_recursive_deps 'js78', determine_recursive_deps('js78')
    end
  end

  def test_no_dependencies
    assert_output("{:clear_cache=>[]}\nclear_cache\n", nil) do
      print_recursive_deps 'clear_cache', determine_recursive_deps('clear_cache')
    end
  end

  def test_multiple_inputs
    assert_equal(%w[autoconf213 clear_cache], order_recursive_deps(%w[clear_cache autoconf213]))

    assert_output("{:autoconf213=>[]}\nautoconf213\n{:clear_cache=>[]}\nclear_cache\n", nil) do
      print_recursive_deps %w[autoconf213 clear_cache], determine_recursive_deps(%w[autoconf213 clear_cache])
    end
  end
end
