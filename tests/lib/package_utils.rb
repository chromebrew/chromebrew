require 'minitest/autorun'
require_relative '../../lib/const'
require_relative '../../lib/package'
require_relative '../../lib/package_utils'

class PackageUtilsTest < Minitest::Test
  def test_installed
    # Ruby is guaranteed to be installed as it is an essential package.
    assert(PackageUtils.installed?('ruby'))
  end

  def test_not_installed
    # Create a nonsense package name which will not be installed.
    refute(PackageUtils.installed?('99notinstalled'))
  end

  def test_compatible_all
    # Packages with 'all' compatibility are compatible on all architectures.
    pkg = Class.new(Package)
    pkg.instance_eval do
      compatibility 'all'
    end
    assert(PackageUtils.compatible?(pkg))
  end

  def test_compatible_multiple_values
    # Packages with a compatibility value that includes the current architecture are compatible with the current architecture.
    pkg = Class.new(Package)
    pkg.instance_eval do
      compatibility "ia64 #{ARCH}"
    end
    assert(PackageUtils.compatible?(pkg))
  end

  def test_compatible_single_value
    # Packages with a compatibility value that is the current architecture are compatible with the current architecture.
    pkg = Class.new(Package)
    pkg.instance_eval do
      compatibility ARCH
    end
    assert(PackageUtils.compatible?(pkg))
  end

  def test_not_compatible_arch
    # No packages are compatible with the Alternate Instruction Set architecture
    pkg = Class.new(Package)
    pkg.instance_eval do
      compatibility 'ais'
    end
    refute(PackageUtils.compatible?(pkg))
  end

  def test_get_binary_url
    pkg = Class.new(Package)
    pkg.name = 'test_package'
    pkg.instance_eval do
      version '1.0'
      binary_compression 'tar.zst'
      binary_sha256({ ARCH.to_sym => '0000000000000000000000000000000000000000000000000000000000000000' })
    end
    assert_equal("https://gitlab.com/api/v4/projects/26210301/packages/generic/test_package/1.0_#{ARCH}/test_package-1.0-chromeos-#{ARCH}.tar.zst", PackageUtils.get_url(pkg))
  end

  def test_get_source_url_hash
    pkg = Class.new(Package)
    pkg.instance_eval do
      source_url({ ARCH.to_sym => 'https://example.com/example_package.tar.bz3' })
    end
    assert_equal('https://example.com/example_package.tar.bz3', PackageUtils.get_url(pkg))
  end

  def test_get_source_url
    pkg = Class.new(Package)
    pkg.instance_eval do
      source_url 'https://example.com/other_example_package.tar.zst'
    end
    assert_equal('https://example.com/other_example_package.tar.zst', PackageUtils.get_url(pkg))
  end

  def test_get_url_build_from_source
    pkg = Class.new(Package)
    pkg.instance_eval do
      version '1.0'
      source_url 'https://example.com/another_example_package.tar.xz'
      binary_compression 'tar.zst'
      binary_sha256({ ARCH.to_sym => '0000000000000000000000000000000000000000000000000000000000000000' })
    end
    assert_equal('https://example.com/another_example_package.tar.xz', PackageUtils.get_url(pkg, build_from_source: true))
  end

  def test_get_binary_sha256
    pkg = Class.new(Package)
    pkg.instance_eval do
      binary_sha256({ ARCH.to_sym => '1111111111111111111111111111111111111111111111111111111111111111' })
    end
    assert_equal('1111111111111111111111111111111111111111111111111111111111111111', PackageUtils.get_sha256(pkg))
  end

  def test_get_source_sha256_hash
    pkg = Class.new(Package)
    pkg.instance_eval do
      source_sha256({ ARCH.to_sym => '2222222222222222222222222222222222222222222222222222222222222222' })
    end
    assert_equal('2222222222222222222222222222222222222222222222222222222222222222', PackageUtils.get_sha256(pkg))
  end

  def test_get_source_sha256
    pkg = Class.new(Package)
    pkg.instance_eval do
      source_sha256 '3333333333333333333333333333333333333333333333333333333333333333'
    end
    assert_equal('3333333333333333333333333333333333333333333333333333333333333333', PackageUtils.get_sha256(pkg))
  end

  def test_get_sha256_build_from_source
    pkg = Class.new(Package)
    pkg.instance_eval do
      source_sha256 '4444444444444444444444444444444444444444444444444444444444444444'
      binary_sha256({ ARCH.to_sym => '0000000000000000000000000000000000000000000000000000000000000000' })
    end
    assert_equal('4444444444444444444444444444444444444444444444444444444444444444', PackageUtils.get_sha256(pkg, build_from_source: true))
  end

  def test_get_clean_python_version
    assert_equal('1.2.3', PackageUtils.get_clean_version('1.2.3-py3.12'))
  end

  def test_get_clean_perl_version
    assert_equal('0.004.2', PackageUtils.get_clean_version('0.004.2-perl5.40'))
  end

  def test_get_clean_llvm_version
    assert_equal('72.93', PackageUtils.get_clean_version('72.93-llvm18'))
  end

  def test_get_clean_glibc_version
    assert_equal('9.5.18', PackageUtils.get_clean_version('9.5.18-glibc2.39'))
  end

  def test_get_clean_git_version
    assert_equal('0.0.7', PackageUtils.get_clean_version('0.0.7-8ab26so'))
    assert_equal('8.2.4-2', PackageUtils.get_clean_version('8.2.4-2-zh725k9'))
    assert_equal('579-4', PackageUtils.get_clean_version('579-4-1628457'))
    assert_equal('2.1.5-20220429', PackageUtils.get_clean_version('2.1.5-20220429'))
  end
end
