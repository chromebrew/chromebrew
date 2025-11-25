require 'minitest/autorun'
require_relative '../../tools/version'

class VersionMonitorTest < Minitest::Test
  def test_get_simple_anitya_id
    assert_equal(15222, get_anitya_id('audaspace', 'https://github.com/audaspace/audaspace', 'CMake'))
  end

  def test_get_nonexistent_anitya_id
    assert_nil(get_anitya_id('99notreal', 'ftp://com.ruby', 'Package'))
  end

  def test_get_pip_gem_anitya_id
    # We shoudn't be attempting to check versions of Pip or Ruby packages, so we just return nil.
    assert_nil(get_anitya_id('py3_unsupported_python', 'https://github.com/ntessore/unsupported-python', 'Pip'))
    assert_nil(get_anitya_id('ruby_typeprof', 'https://github.com/ruby/typeprof', 'RUBY'))
  end

  def test_get_dashed_anitya_id
    # If we weren't able to find an anitya package using the package name, we try again using dashes instead of underscores.
    assert_equal(115295, get_anitya_id('abseil_cpp', 'https://abseil.io/', 'CMake'))
    assert_equal(13117, get_anitya_id('adwaita_icon_theme', 'https://wiki.gnome.org/Design', 'Meson'))
  end

  def test_get_nonexistent_dashed_anitya_id
    assert_nil(get_anitya_id('99_still_notreal', 'ftp://com.crystal', 'Package'))
  end

  def test_get_multi_ecosystem_anitya_id
    # This should eliminate all the other candidates due to their ecosystems, so the homepage isn't even checked.
    assert_equal(217, get_anitya_id('bridge_utils', 'https://wiki.linuxfoundation.org/networking/bridge', 'Package'))
    assert_equal(217, get_anitya_id('bridge_utils', 'example.com', 'Package'))
    # If we pretend we're a Python package, the other candidates should still get eliminated by homepage checking.
    assert_equal(217, get_anitya_id('bridge_utils', 'https://wiki.linuxfoundation.org/networking/bridge', 'Python'))
    # If we pretend we're a Python package and give a dummy homepage, we shouldn't be able to choose and will return nil.
    assert_nil(get_anitya_id('bridge_utils', 'example.com', 'Python'))
  end

  def test_get_multi_homepage_anitya_id
    # Both candidates for check will pass the ecosystem check, so the differentiation will be done by homepage checking.
    assert_equal(7593, get_anitya_id('check', 'https://libcheck.github.io/check/', 'CMake'))
    # Test that our fuzzy homepage matching properly ignores the scheme and www subdomain when checking homepage equality.
    assert_equal(7593, get_anitya_id('check', 'http://libcheck.github.io/check/', 'CMake'))
    assert_equal(7593, get_anitya_id('check', 'https://www.libcheck.github.io/check/', 'CMake'))
    # If we aren't able to match by homepage, we should return nil.
    assert_nil(get_anitya_id('check', 'example.com', 'CMake'))
  end

  def test_get_multi_homepage_ecosystem_anitya_id
    # There should be multiple candidates that survive the ecosystem check, but only one will pass the homepage check.
    assert_equal(247, get_anitya_id('cairo', 'https://www.cairographics.org', 'Meson'))
  end
end
