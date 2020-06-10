require 'package'

class Libcdio < Package
  description 'The GNU Compact Disc Input and Control library (libcdio) contains a library for CD-ROM and CD image access.'
  homepage 'http://www.gnu.org/software/libcdio/'
  version '2.0.0'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/libcdio/libcdio-2.0.0.tar.gz'
  source_sha256 '1b481b5da009bea31db875805665974e2fc568e2b2afa516f4036733657cf958'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcdio-2.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcdio-2.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcdio-2.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcdio-2.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '96fe10d82e1165af8ddf59512c0f5e47adbebab38fcdb9741e687fc591075e98',
     armv7l: '96fe10d82e1165af8ddf59512c0f5e47adbebab38fcdb9741e687fc591075e98',
       i686: '0f4cd7753e6ba8c5304769fbebdd7c9603ed8841c1085e50d79f1ee9091f2857',
     x86_64: 'b3e6ab517eaae30320ffbdc3f6874b250f59783dfb35708590e6fd22782e89ac',
  })

  depends_on 'libcddb'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-cdda-player',
           '--disable-maintainer-mode',
           '--disable-static'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
