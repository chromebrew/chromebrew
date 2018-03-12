require 'package'

class Libwayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.14.91'
  source_url 'https://wayland.freedesktop.org/releases/wayland-1.14.91.tar.xz'
  source_sha256 '25b9d3dd8a69b1b3533cf1b98e5a48f6b1466799171d429778b69c41bc477ef8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwayland-1.14.91-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwayland-1.14.91-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwayland-1.14.91-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwayland-1.14.91-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '831a11987aea55aa4f74cb128626399dead299409a2c51d1fc2516b14fb4655a',
     armv7l: '831a11987aea55aa4f74cb128626399dead299409a2c51d1fc2516b14fb4655a',
       i686: 'cd182ec064b533c9625cc7e7495e6982058a6ef82064860b4db61ff7f3cd691b',
     x86_64: '70ac6ef44c5c0060f005c85c1b8a570c524f3245c532db3ade547de2a0e5ad72',
  })

  depends_on 'libffi'
  depends_on 'expat'
  depends_on 'libxml2'
  depends_on 'libxslt'  

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --disable-documentation"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
