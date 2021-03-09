require 'package'

class Libxss < Package
  description 'X11 Screen Saver extension library'
  homepage 'https://gitlab.freedesktop.org/xorg/lib/libxscrnsaver'
  @_ver = '1.2.3'
  version @_ver
  compatibility 'all'
  source_url "https://xorg.freedesktop.org/releases/individual/lib/libXScrnSaver-#{@_ver}.tar.bz2"
  source_sha256 'f917075a1b7b5a38d67a8b0238eaab14acd2557679835b154cf2bca576e89bf8'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxss-1.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxss-1.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxss-1.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxss-1.2.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cec3f0b92f4c56b7ec262ec05356f6304b6e5e651f3074abdb08177a4ef10099',
     armv7l: 'cec3f0b92f4c56b7ec262ec05356f6304b6e5e651f3074abdb08177a4ef10099',
       i686: 'a7c94cac209cda5532aba55897b7334586881757f47eeaaf136e64b9f5cdeb0a',
     x86_64: '4de949279407adf9abf83328e51e7d86c0630ec2eae6925aa3fc02fe4a0166a5'
  })

  depends_on 'libxext'
  depends_on 'util_macros' => ':build'

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
