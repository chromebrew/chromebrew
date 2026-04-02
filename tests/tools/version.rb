require 'minitest/autorun'
require_relative '../../tools/version'

def update_package_test_wrapper(input_file, version, expected_pkg_file, version_updated: true, bc_updated: nil)
  # Create a temporary file in the packages directory with the filename of the class name of the input package.
  package_file_path = "#{CREW_LOCAL_REPO_ROOT}/packages/#{input_file.match('class ([A-z][a-z]*) < Package')[1]}.rb"
  File.write(package_file_path, input_file)

  # Update the temporary package file, checking that we get the right return values
  assert_equal [version_updated, bc_updated], update_package_file(package_file_path, version)

  # Check that the updated temporary package file matches our expectations.
  assert_equal File.read(package_file_path), expected_pkg_file

  # Delete the temporary package file.
  FileUtils.rm(package_file_path)
end

class VersionMonitorTest < Minitest::Test
  def test_github_fallback
    assert_equal('2025-11-03', github_fallback(URI.parse('https://github.com/artichoke/nightly.git')))
    assert_equal('1.0.19', github_fallback(URI.parse('https://github.com/mcxiaoke/android-volley.git')))
    assert_nil(github_fallback(URI.parse('https://github.com/artichoke/artichoke.git')))
    assert_nil(github_fallback(URI.parse('https://github.com/99notreal/99notreal.git')))
  end

  def test_gitlab_fallback
    assert_equal('1.0.0', gitlab_fallback(URI.parse('https://gitlab.com/caseif/fs2sbc.git')))
    assert_nil(gitlab_fallback(URI.parse('https://gitlab.com/erikschull/Simple-Camera-Abandoned.git')))
    assert_nil(gitlab_fallback(URI.parse('https://gitlab.com/99notreal/99notreal.git')))
  end

  def test_sourceforge_fallback
    assert_equal('0.7.1', sourceforge_fallback(URI.parse('http://downloads.sourceforge.net/project/netcat/netcat/0.7.1/netcat-0.7.1.tar.gz')))
    assert_nil(sourceforge_fallback(URI.parse('https://downloads.sourceforge.net/project/99notreal/99notreal.odz')))
  end

  def test_pagure_fallback
    # This repo has been archived for 7 years, so hopefully there won't be any new releases.
    assert_equal('18.0.0-5', pagure_fallback(URI.parse('https://pagure.io/release-notes')))
    assert_nil(pagure_fallback(URI.parse('https://pagure.io/test')))
    assert_nil(pagure_fallback(URI.parse('https://pagure.io/99notreal')))
  end

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

  def test_get_prefixed_anitya_id
    assert_equal(2636, get_anitya_id('perl_app_cpanminus', 'https://metacpan.org/pod/App::cpanminus', 'PERL'))
    # We use the Anitya homepage for maturin here to simplify testing.
    assert_equal(42653, get_anitya_id('py3_maturin', 'https://www.maturin.rs', 'Python'))
    # Every ruby_ package has the RUBY buildsystem, so we lie here to test the behavior.
    # Technically that means we don't need the behavior right now, but things may change.
    assert_equal(139836, get_anitya_id('ruby_typeprof', 'https://github.com/ruby/typeprof', 'Package'))
  end

  def test_get_split_anitya_id
    assert_equal(6502, get_anitya_id('gcc_build', 'https://www.gnu.org/software/gcc/', 'Package'))
    assert_equal(6502, get_anitya_id('gcc_dev', 'https://www.gnu.org/software/gcc/', 'Package'))
    assert_equal(6502, get_anitya_id('gcc_lib', 'https://www.gnu.org/software/gcc/', 'Package'))
  end

  def test_get_static_anitya_id
    assert_equal(12083, get_anitya_id('zstd_static', 'https://facebook.github.io/zstd/', 'Package'))
  end

  def test_get_mapped_anitya_id
    assert_equal(1783, get_anitya_id('libxml2_autotools', 'http://xmlsoft.org/', 'Autotools'))
    assert_equal(6502, get_anitya_id('libssp', 'https://gcc.gnu.org/', 'Autotools'))
    assert_equal(4194, get_anitya_id('rest', 'https://wiki.gnome.org/Projects/Librest', 'Meson'))
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

  def test_update_package_file_version
    input_file = <<~EOF
      class Foo < Package
        version '1.16.1'
        binary_compression 'tar.zst'
      end
    EOF

    update_package_test_wrapper(input_file, '1.0', input_file.sub('1.16.1', '1.0'))
  end

  def test_update_package_file_xz_binary_compression
    input_file = <<~EOF
      class Bar < Package
        version '3.65.0'
        binary_compression 'tar.xz'
      end
    EOF

    update_package_test_wrapper(input_file, '3.65.0', input_file.sub("binary_compression 'tar.xz'", "binary_compression 'tar.zst'"), bc_updated: true)
  end

  def test_update_package_file_xz_binary_compression_no_zstd
    input_file = <<~EOF
      class Foobarr < Package
        version '1.0.0'
        binary_compression 'tar.xz'

        no_zstd
      end
    EOF

    update_package_test_wrapper(input_file, '1.0.0', input_file)
  end

  def test_update_package_file_tpxz_binary_compression
    input_file = <<~EOF
      class Frob < Package
        version '1ca'
        binary_compression 'tpxz'
      end
    EOF

    update_package_test_wrapper(input_file, '1ca', input_file.sub("binary_compression 'tpxz'", "binary_compression 'tar.zst'"), bc_updated: true)
  end

  def test_update_package_file_version_source_sha256
    input_file = <<~'EOF'
      class Qux < Package
        version '1.0.0'
        binary_compression 'tar.zst'
        source_url "https://www.samba.org/ftp/ldb/ldb-#{version}.tar.gz"
        source_sha256 'c63eaca1f84d5149c38ff747f9ac83d05edcd0b5b5d7c0b836100685f968795d'
      end
    EOF

    update_package_test_wrapper(input_file, '1.0.2', input_file.sub('1.0.0', '1.0.2').sub('c63eaca1f84d5149c38ff747f9ac83d05edcd0b5b5d7c0b836100685f968795d', '275a8c2ce111558d7ae573ee6922c86eda6d0df2280721e18b3aa8166e5ab3fb'))
  end

  def test_update_package_file_version_multi_source_sha256
    input_file = <<~'EOF'
      class Quux < Package
        version '0.5.0'
        binary_compression 'tar.zst'
        source_url({
          armv7l: "https://github.com/koalaman/shellcheck/releases/download/v#{version}/shellcheck-v#{version}.linux.armv6hf.tar.xz",
          x86_64: "https://github.com/koalaman/shellcheck/releases/download/v#{version}/shellcheck-v#{version}.linux.x86_64.tar.xz"
        })
        source_sha256({
          armv7l: '49a0a2c75a464f35b17c2254f979e48b460350ad3eccffdec53f9ee746950950',
          x86_64: '7d4c073a0342cf39bdb99c32b4749f1c022cf2cffdfb080c12c106aa9d341708'
        })

      end
    EOF

    update_package_test_wrapper(input_file, '0.7.2', input_file.sub('0.5.0', '0.7.2').sub('49a0a2c75a464f35b17c2254f979e48b460350ad3eccffdec53f9ee746950950', '29c7291985ad391fc8af930ba89c7441d5764aa3415ef1d77171aea0b34d35b9').sub('7d4c073a0342cf39bdb99c32b4749f1c022cf2cffdfb080c12c106aa9d341708', '70423609f27b504d6c0c47e340f33652aea975e45f312324f2dbf91c95a3b188'))
  end

  def test_update_package_file_version_bad_source_sha256
    input_file = <<~'EOF'
      class Quuux < Package
        version '3.56.0'
        binary_compression 'tar.zst'
        source_url "https://example.com/#{version}.tar.gz"
        source_sha256 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii'
      end
    EOF

    update_package_test_wrapper(input_file, '9.1.8', input_file, version_updated: 'Bad Source', bc_updated: nil)
  end

  # TODO: Why doesn't this have the same behavior as the single source_url case?
  def test_update_package_file_version_bad_multi_source_sha256
    input_file = <<~'EOF'
      class Quuuux < Package
        version '1.4.0'
        binary_compression 'tar.zst'
        source_url({
          armv7l: "ftp://example.hats/ia32-#{version}.tar.bz3",
            i686: "ftp://example.hats/strongarmv7-#{version}.tar.bz3"
        })
        source_sha256({
          armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
            i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii'
        })
      end
    EOF

    update_package_test_wrapper(input_file, '2.7.0', input_file.sub('1.4.0', '2.7.0'))
  end
end
