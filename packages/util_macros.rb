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
    aarch64: '42bfc95875cfcee649d1a66cfea163f64d3426cbc07b37c05af920a0d5e54cf9',
     armv7l: '42bfc95875cfcee649d1a66cfea163f64d3426cbc07b37c05af920a0d5e54cf9',
       i686: 'ab596326234a9a8be37027980f9c63abda60705a85ae2edfc6e891a862f74519',
     x86_64: 'c2fe3d08599cb0a2b4a0a23b5647f2e8e9959073c0d817157814d05be49ddc83'
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
