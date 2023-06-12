# Adapted from Arch Linux p8-platform PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/p8-platform/trunk/PKGBUILD

require 'package'

class P8_platform < Package
  description 'Platform support library used by libCEC and binary add-ons for Kodi'
  homepage 'https://github.com/Pulse-Eight/platform'
  version '2.1.0.1'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/Pulse-Eight/platform/archive/p8-platform-2.1.0.1.tar.gz'
  source_sha256 '064f8d2c358895c7e0bea9ae956f8d46f3f057772cb97f2743a11d478a0f68a0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p8_platform/2.1.0.1_armv7l/p8_platform-2.1.0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p8_platform/2.1.0.1_armv7l/p8_platform-2.1.0.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p8_platform/2.1.0.1_i686/p8_platform-2.1.0.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p8_platform/2.1.0.1_x86_64/p8_platform-2.1.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a9965e17d92856f22cb5b822aa1d289d31fa41c5c88e6d5a6bf5cf549c1459ab',
     armv7l: 'a9965e17d92856f22cb5b822aa1d289d31fa41c5c88e6d5a6bf5cf549c1459ab',
       i686: '4a010435dbd9882568d55af7582e127645ffd72e697f5b0012eaec79d98a3369',
     x86_64: '0f6e3ba79c0f2ea8ddcbe704e04000b439ebc7b15cfbc8d8d6217ff56569e3ca'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    FileUtils.mkdir_p 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX} \
        -DCMAKE_INSTALL_LIBDIR_NOARCH=#{CREW_LIB_PREFIX} \
        -DBUILD_SHARED_LIBS=1 \
        -Wno-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
