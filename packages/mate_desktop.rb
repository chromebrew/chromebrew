require 'package'

class Mate_desktop < Package
  description 'Libraries for the MATE desktop that are not part of the UI.'
  homepage 'https://mate-desktop.org'
  version '1.20-0'
  compatibility 'all'
  source_url 'https://pub.mate-desktop.org/releases/1.20/mate-desktop-1.20.0.tar.xz'
  source_sha256 '36d0722750ce30ba8d4b8b735bef6ad1b1b4c8f9f51257e36ec419b9b438a178'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mate_desktop-1.20-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mate_desktop-1.20-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mate_desktop-1.20-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mate_desktop-1.20-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '159fe66a17c142fa7f34f6801a40fd51812155963f1cc57edccf50e2505ace32',
     armv7l: '159fe66a17c142fa7f34f6801a40fd51812155963f1cc57edccf50e2505ace32',
       i686: '99e55f73a566592af122e5d0b995538dad2ff73235fd8a8c972b3473524267d2',
     x86_64: '51c066b5ebf3806fbcfa0cd58bc2ebc7874e2889e16e2a6efd97bdfa22c77388',
  })

  depends_on 'mate_common'
  depends_on 'dconf'
  depends_on 'six' => :build

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
