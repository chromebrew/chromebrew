require 'package'

class Zlibpkg < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://www.zlib.net/'
  @_ver = '1.2.13'
  version @_ver
  # When upgrading zlibpkg, be sure to upgrade minizip in tandem.
  # The following breaks the installer script.
  # puts "#{self} version differs from Minizip version #{Minizip.version}".orange if @_ver != Minizip.version
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{@_ver}.tar.gz"
  source_sha256 'b3a24de97a8fdbc835b9833169501030b8977031bcb54b3b3ac13740f846ab30'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.13_armv7l/zlibpkg-1.2.13-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.13_armv7l/zlibpkg-1.2.13-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.13_i686/zlibpkg-1.2.13-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.13_x86_64/zlibpkg-1.2.13-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a8b06cf54f2cf380588f65aad72287dba2e79e89a9ff13da64e2f54e0e79dd2c',
     armv7l: 'a8b06cf54f2cf380588f65aad72287dba2e79e89a9ff13da64e2f54e0e79dd2c',
       i686: '3b5f806293a0a82dc89198ced41a72b81d4e2e6d0cd5542d64471d92e877ebc6',
     x86_64: '535eb1176d122ebd9bbae77d9e6a3c0cd055d20ec4908ad2aa47971badc3e527'
  })

  depends_on 'glibc' # R

  def self.patch
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/lib,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB},g' CMakeLists.txt"
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/share/pkgconfig,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB}/pkgconfig,g' CMakeLists.txt"
  end

  def self.build
    system "cmake -B builddir -G Ninja #{CREW_CMAKE_OPTIONS}"
    system 'samu -C builddir'
  end

  def self.check
    system 'samu -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
