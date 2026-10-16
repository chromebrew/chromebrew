require 'buildsystems/cmake'

class Zlib < CMake
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://www.zlib.net'
  version '1.3.2' # Do not use @_ver here, it will break the installer.
  # When upgrading zlib, be sure to upgrade minizip in tandem.
  # The following breaks the installer script.
  # puts "#{self} version differs from Minizip version #{Minizip.version}".orange if @_ver != Minizip.version
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{version}.tar.gz"
  source_sha256 'bb329a0a2cd0274d05519d61c667c062e06990d72e125ee2dfa8de64f0119d16'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b3fb3bcafd89891b4753a8cfc8fa9c403dc640b44fbab1a1f0acc835ea122bd4',
     armv7l: 'b3fb3bcafd89891b4753a8cfc8fa9c403dc640b44fbab1a1f0acc835ea122bd4',
       i686: '9e509074fe20bbf197744a0804e4324c179357457458903e38e636ee194aedb7',
     x86_64: 'db229bc497816f8fbc930af5a717ac5e73c6641b89c67ac57f8a05d22ea466fe'
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
