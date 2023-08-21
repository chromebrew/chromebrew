require 'buildsystems/cmake'

class Zlibpkg < CMake
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://www.zlib.net/'
  version '1.3' # Do not use @_ver here, it will break the installer.
  # When upgrading zlibpkg, be sure to upgrade minizip in tandem.
  # The following breaks the installer script.
  # puts "#{self} version differs from Minizip version #{Minizip.version}".orange if @_ver != Minizip.version
  license 'zlib'
  compatibility 'all'
  source_url 'https://www.zlib.net/zlib-1.3.tar.gz'
  source_sha256 'ff0ba4c292013dbc27530b3a81e1f9a813cd39de01ca5e0f8bf355702efa593e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.3_armv7l/zlibpkg-1.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.3_armv7l/zlibpkg-1.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.3_i686/zlibpkg-1.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.3_x86_64/zlibpkg-1.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e95b8506d089079f85e73a55059f45ed020b7ae63a68f082232f3c365bfdf10a',
     armv7l: 'e95b8506d089079f85e73a55059f45ed020b7ae63a68f082232f3c365bfdf10a',
       i686: 'b5d5a45fe613175d51080e53135f5029f7979fb8c8499471daccdfaa18ad1485',
     x86_64: 'fbb3d244868be3fe85fe9f029249f6be267ecd5545419482d50cb3ba33a30215'
  })

  depends_on 'glibc' # R

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
