require 'buildsystems/cmake'

class Zlibpkg < CMake
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://www.zlib.net/'
  version '1.3.1' # Do not use @_ver here, it will break the installer.
  # When upgrading zlibpkg, be sure to upgrade minizip in tandem.
  # The following breaks the installer script.
  # puts "#{self} version differs from Minizip version #{Minizip.version}".orange if @_ver != Minizip.version
  license 'zlib'
  compatibility 'all'
  source_url 'https://www.zlib.net/zlib-1.3.1.tar.gz'
  source_sha256 '9a93b2b7dfdac77ceba5a558a580e74667dd6fede4585b91eefb60f03b72df23'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.3.1_armv7l/zlibpkg-1.3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.3.1_armv7l/zlibpkg-1.3.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.3.1_i686/zlibpkg-1.3.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.3.1_x86_64/zlibpkg-1.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a5eb9bbd6dce00c096617c1db16a71dd1f590043c39519e1645d5eb9750ed88f',
     armv7l: 'a5eb9bbd6dce00c096617c1db16a71dd1f590043c39519e1645d5eb9750ed88f',
       i686: '1e4ae082c29430d3c081b3f9a8a66bebc9c6cfbf5912476a5ddcfc5c00edfcf2',
     x86_64: '84abb78b6aabdcb976484173d6b8c53c25495db8a30cd729a584d56d2d66722f'
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
