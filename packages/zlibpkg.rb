require 'package'

class Zlibpkg < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://www.zlib.net/'
  # When upgrading zlibpkg, be sure to upgrade minizip in tandem.
  @_ver = '1.2.12'
  version @_ver.to_s
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{@_ver}.tar.gz"
  source_sha256 '91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.12_armv7l/zlibpkg-1.2.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.12_armv7l/zlibpkg-1.2.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.12_i686/zlibpkg-1.2.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.12_x86_64/zlibpkg-1.2.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'de52ec010a7decfd04e10a29bf33d4f77d4eceed9df9b07bf4b4df9db4116c56',
     armv7l: 'de52ec010a7decfd04e10a29bf33d4f77d4eceed9df9b07bf4b4df9db4116c56',
       i686: '0e829ac458b3f6e3fcb5314b775e869ed7a6a7225dde7a40c07e66e4240db266',
     x86_64: '8d7c564fa93fd091ac36d0923acc8802a8d46f82b593e9be56b0a9252ad45fbe'
  })

  depends_on 'glibc' # R

  def self.patch
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/lib,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB},g' CMakeLists.txt"
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/share/pkgconfig,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB}/pkgconfig,g' CMakeLists.txt"
  end

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -Wno-dev \
        .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
