require 'buildsystems/cmake'

class Zlib < CMake
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://www.zlib.net'
  version '1.4' # Do not use @_ver here, it will break the installer.
  # When upgrading zlib, be sure to upgrade minizip in tandem.
  # The following breaks the installer script.
  # puts "#{self} version differs from Minizip version #{Minizip.version}".orange if @_ver != Minizip.version
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{version}.tar.gz"
  source_sha256 '02dd159783677a749c04adbdd02b55b8a2bcc7e054f51b76b549199a916ad584'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dc6e5ec9574af5566df155c18d9b5ede357c53740c89a33e2009f42202ffa033',
     armv7l: 'dc6e5ec9574af5566df155c18d9b5ede357c53740c89a33e2009f42202ffa033',
       i686: '1a5cc0df474dbd687760ff6f0e66de34f5cba6ac1cd9863ef365e40ceff4a961',
     x86_64: '6c61ab5106cd95a9aee60146a0af22fbaea79e31bba067b0c78fd4a62afd3e03'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options "#{CREW_CMAKE_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} -Wno-author -DZLIB_BUILD_TESTING=OFF"

  # Tests fail with:
  # 9/18 Test #17: zlib_add_subdirectory_exclude_build.............***Failed    0.01 sec
  # ninja: error: loading 'build.ninja': No such file or directory
  # 9/18 Test #18: zlib_add_subdirectory_exclude_testFailed test dependencies: zlib_add_subdirectory_exclude_build
  # run_tests

  def self.patch
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/lib,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB},g' CMakeLists.txt"
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/share/pkgconfig,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB}/pkgconfig,g' CMakeLists.txt"
  end
end
