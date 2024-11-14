require 'buildsystems/cmake'

class Zlib < CMake
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://zlib.net'
  version '1.3.1-1' # Do not use @_ver here, it will break the installer.
  # When upgrading zlib, be sure to upgrade minizip in tandem.
  # The following breaks the installer script.
  # puts "#{self} version differs from Minizip version #{Minizip.version}".orange if @_ver != Minizip.version
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{version.split('-').first}.tar.gz"
  source_sha256 '9a93b2b7dfdac77ceba5a558a580e74667dd6fede4585b91eefb60f03b72df23'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '088ea9b1d7a0b4d4d99ab52d44a0e583b3d70c1fc7b12fdb07ec00fecf1c0974',
     armv7l: '088ea9b1d7a0b4d4d99ab52d44a0e583b3d70c1fc7b12fdb07ec00fecf1c0974',
       i686: '12af9f1f76a2010c9d4a613db6e7898e7a3ff0e3279da67643162dbf0e26bbd0',
     x86_64: '6207497dc60b168b8e5de2d68465e27131631f810c694329cb456e7daa20fdba'
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
