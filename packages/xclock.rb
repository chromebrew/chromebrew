require 'package'

class Xclock < Package
  description 'The xclock package contains a simple clock application which is used in the default xinit configuration.'
  homepage 'https://www.x.org/archive/X11R6.8.1/doc/xclock.1.html'
  version '1.0.7'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/app/xclock-1.0.7.tar.bz2'
  source_sha256 '23ceeca94e3e20a6c26a703ac7f789066d4517f8d2cb717ae7cb28a617d97dd0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xclock-1.0.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xclock-1.0.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xclock-1.0.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xclock-1.0.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '589fb2e417aead9724d278e8f675bcd5d6f53d717fdd9d5b208e9a69ad3e0cfc',
     armv7l: '589fb2e417aead9724d278e8f675bcd5d6f53d717fdd9d5b208e9a69ad3e0cfc',
       i686: '24bac5e6ab7b90d6eb070e587e6e473cfcab04f46b47dc1801d5bfcac6467d3f',
     x86_64: '51318c17142f85d70173ce506a2f04a8b66ee8382e821e782e07548076051a1c',
  })

  depends_on 'xorg_lib'

  def self.build
    system './configure', "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
