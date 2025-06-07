require 'buildsystems/cmake'

class Zlib < CMake
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://zlib.net'
  version '1.3.1-2' # Do not use @_ver here, it will break the installer.
  # When upgrading zlib, be sure to upgrade minizip in tandem.
  # The following breaks the installer script.
  # puts "#{self} version differs from Minizip version #{Minizip.version}".orange if @_ver != Minizip.version
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{version.split('-').first}.tar.gz"
  source_sha256 '9a93b2b7dfdac77ceba5a558a580e74667dd6fede4585b91eefb60f03b72df23'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'b78cc677fde2ccc7464e06076db20b0a8999d0dd165447e5fd9d07b68d337f45',
     armv7l: 'b78cc677fde2ccc7464e06076db20b0a8999d0dd165447e5fd9d07b68d337f45',
       i686: 'd9ca99faf6633b9aa675bb721b89c0dd4aabaddcda3746c4dfad1e54b8437c2d',
     x86_64: '4018bdcde1651a846f079b8c4f9f3f4a9c9da260d5caf9329da3a6d0b1ac6fdb'
  })

  depends_on 'glibc' # R
  no_zstd

  cmake_options "#{CREW_CMAKE_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} -Wno-dev"

  run_tests

  def self.patch
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/lib,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB},g' CMakeLists.txt"
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/share/pkgconfig,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB}/pkgconfig,g' CMakeLists.txt"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    # Remove static library.
    FileUtils.rm "#{CREW_DEST_LIB_PREFIX}/libz.a"
  end
end
