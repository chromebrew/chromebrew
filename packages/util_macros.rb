require 'package'

class Util_macros < Package
  description 'The util-macros package contains the m4 macros used by all of the Xorg packages'
  homepage 'https://www.linuxfromscratch.org/blfs/view/svn/util-macros.html'
  @_ver = '1.19.3'
  version @_ver
  compatibility 'all'
  source_url "https://xorg.freedesktop.org/releases/individual/util/util-macros-#{@_ver}.tar.bz2"
  source_sha256 '0f812e6e9d2786ba8f54b960ee563c0663ddbe2434bf24ff193f5feab1f31971'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_util_macros-1.19.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_util_macros-1.19.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_util_macros-1.19.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_util_macros-1.19.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5ff671e17592e9c7d771aa0c80674aa64c457b6bff87a9553de198d4664e8ee5',
     armv7l: '5ff671e17592e9c7d771aa0c80674aa64c457b6bff87a9553de198d4664e8ee5',
       i686: 'e9feda16b4fd408253af38a2f2687db4fbde3b8a5a24125a317d859c389a75c9',
     x86_64: '22cae36ecdc1686f1f8f82c4d7d7de442b0f0eac70c549a72a9ec73f50dd01c5'
  })

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
