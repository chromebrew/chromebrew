require 'package'

class Zlibpkg < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://www.zlib.net/'
  @_ver = '1.2.13'
  version "#{@_ver}-1"
  # When upgrading zlibpkg, be sure to upgrade minizip in tandem.
  # The following breaks the installer script.
  # puts "#{self} version differs from Minizip version #{Minizip.version}".orange if @_ver != Minizip.version
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{@_ver}.tar.gz"
  source_sha256 'b3a24de97a8fdbc835b9833169501030b8977031bcb54b3b3ac13740f846ab30'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.13-1_armv7l/zlibpkg-1.2.13-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.13-1_armv7l/zlibpkg-1.2.13-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.13-1_i686/zlibpkg-1.2.13-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.13-1_x86_64/zlibpkg-1.2.13-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4d1da86d9682dcf90538cce22f4650b7c2a35dff251d613783b446023eb7d211',
     armv7l: '4d1da86d9682dcf90538cce22f4650b7c2a35dff251d613783b446023eb7d211',
       i686: 'e772f09b58ac0ea37e6845da3aefcb217631de37daeaa9863d7f96d74c3dc45b',
     x86_64: 'a8a3748e34f5a19bf2696cfef5a95642dd138996ae06acda06a1527a0a793dd7'
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
    # Remove static library.
    FileUtils.rm "#{CREW_DEST_LIB_PREFIX}/libz.a"
  end
end
