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

  def test_get_binary_url_old_hash
    pkg = Class.new(Package)
    pkg.name = 'hello_world_chromebrew'
    pkg.instance_eval do
      version '1.1'
      binary_compression 'tar.zst'
      binary_sha256({
        aarch64: '29185a6c4a8ecc3532606649f5831e37cd977c24bfd4fb1c12328ca5ba966ff1',
         armv7l: '29185a6c4a8ecc3532606649f5831e37cd977c24bfd4fb1c12328ca5ba966ff1',
           i686: '6e46c31245e9e17eeecf03d61454bb7312b6e769bfaf352ced527ee93cc62518',
         x86_64: '83f674b3e8fe29c7e761ce6adc27fd7df927d985140ff6d1ae64a0046339322b'
      })
    end
    package_file_id = { aarch64: '137956464', armv7l: '137956464', i686: '137956442', x86_64: '137956370' }
    assert_equal("https://gitlab.com/chromebrew/binaries/-/package_files/#{package_file_id[ARCH.to_sym]}/download", PackageUtils.get_url(pkg))
  end

  def test_get_binary_url_new_hash
    pkg = Class.new(Package)
    pkg.name = 'hello_world_chromebrew'
    pkg.instance_eval do
      version '1.1'
      binary_compression 'tar.zst'
      binary_sha256({
        aarch64: '827f9794864aa76f4c99fd31f989077f1fa65771386f73db30a7681842f8736d',
         armv7l: '827f9794864aa76f4c99fd31f989077f1fa65771386f73db30a7681842f8736d',
           i686: 'ff0942c505b04982fed187bcda123adead37b3ac2dcfd7e2f0543ca179e81df6',
         x86_64: '3081f1f25950c91f75db41095b644a2783987a3a7ef2832fc2b85bf138bb006f'
      })
    end
    package_file_id = { aarch64: '137956527', armv7l: '137956527', i686: '137956521', x86_64: '137956520' }
    assert_equal("https://gitlab.com/chromebrew/binaries/-/package_files/#{package_file_id[ARCH.to_sym]}/download", PackageUtils.get_url(pkg))
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

  def test_get_clean_ruby_version
    assert_equal('99.95', PackageUtils.get_clean_version('99.95-ruby3.4'))
  end

  def test_get_clean_perl_version
    assert_equal('0.004.2', PackageUtils.get_clean_version('0.004.2-perl5.40'))
  end

  def test_get_clean_llvm_version
    assert_equal('72.93', PackageUtils.get_clean_version('72.93-llvm18'))
  end

  def test_get_clean_glibc_version
    assert_equal('9.5.18', PackageUtils.get_clean_version("9.5.18-glibc#{LIBC_VERSION}"))
  end

  def test_get_clean_git_version
    assert_equal('0.0.7', PackageUtils.get_clean_version('0.0.7-8ab26so'))
    assert_equal('8.2.4-2', PackageUtils.get_clean_version('8.2.4-2-zh725k9'))
    assert_equal('579-4', PackageUtils.get_clean_version('579-4-1628457'))
    assert_equal('2.1.5-20220429', PackageUtils.get_clean_version('2.1.5-20220429'))
  end
end
