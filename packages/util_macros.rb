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
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/util_macros-1.19.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/util_macros-1.19.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/util_macros-1.19.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/util_macros-1.19.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e97980e3df0457a1067a42e907f68c31b6be5fa7199cd259ab2ff318c0358246',
     armv7l: 'e97980e3df0457a1067a42e907f68c31b6be5fa7199cd259ab2ff318c0358246',
       i686: 'd1d50eb7b3cdbec100fd3d91a3e86400e9abc8fbc648c97423b5678a783cf5f2',
     x86_64: 'fdf6e08157bac20b6bae42bd63b3ddbe99d67604a63fee47bd405e2c5fac71ec'
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
