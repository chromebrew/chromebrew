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
    aarch64: '26f4076cb8286135fd4f6912fb07d1a12da5f0f4447d3656a9bf76f52b6cf83d',
     armv7l: '26f4076cb8286135fd4f6912fb07d1a12da5f0f4447d3656a9bf76f52b6cf83d',
       i686: '42aa72fec758a9ecf8a87a2a7bc5c40eb7a5c988e10dfa86feb5d75e3ca9de95',
     x86_64: '196e293ec2ee7c06bc8bbd3746001781e9ad2e06bb57b61e442e8fe72f903d08'
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
