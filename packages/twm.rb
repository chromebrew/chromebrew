require 'package'

class Twm < Package
  description 'The twm package contains a very minimal window manager.'
  homepage 'http://www.linuxfromscratch.org/blfs/view/svn/x/twm.html'
  version '1.0.10'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/app/twm-1.0.10.tar.bz2'
  source_sha256 '6449eadca16ce0f0d900605b0cc020b95f40619261b7beccfb46bcc1836445d7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/twm-1.0.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/twm-1.0.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/twm-1.0.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/twm-1.0.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e5b66bf042c287bf844da9a0ac2cff8c0af7d679ddcb83bea15b4b9a580534bf',
     armv7l: 'e5b66bf042c287bf844da9a0ac2cff8c0af7d679ddcb83bea15b4b9a580534bf',
       i686: '3abf216bc7c9a2e8f8f43ea263c46fe6c7e366d37e6195ac256c0123de5ce37c',
     x86_64: '2db77d9f08c7c9090e7bc663b00f4c052442addd01fd614220603ec555e16af9',
  })

  depends_on 'xorg_server'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
