require 'package'

class Xf86bigfontproto < Package
  description 'X.org XF86BigFont protocol headers'
  homepage 'http://www.x.org'
  version '1.2.0'
  source_url 'https://www.x.org/archive/individual/proto/xf86bigfontproto-1.2.0.tar.gz'
  source_sha256 'd190e6462b2bbbac6ee9a007fb8eccb9ad9f5f70544154f388266f031d4bbb23'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xf86bigfontproto-1.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xf86bigfontproto-1.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xf86bigfontproto-1.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xf86bigfontproto-1.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f46d0de21067a604c862a945409a33cd6b202e28e74b046673d0d461f877478e',
     armv7l: 'f46d0de21067a604c862a945409a33cd6b202e28e74b046673d0d461f877478e',
       i686: 'f174709609adab0df52f39a26ea6b4d16a2255bf2d9e6ccf65ef2cdb86b82708',
     x86_64: '5d36c3a55427de64fcd6d174b2cd92852f7bbd77a650c35da5befa8533769b7e',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
