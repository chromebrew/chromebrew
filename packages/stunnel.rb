require 'package'

class Stunnel < Package
  description "Stunnel is a proxy designed to add TLS encryption functionality to existing clients and servers without any changes in the programs' code."
  homepage 'https://www.stunnel.org/index.html'
  version '5.42'
  compatibility 'all'
  source_url 'https://www.stunnel.org/downloads/stunnel-5.42.tar.gz'
  source_sha256 '1b6a7aea5ca223990bc8bd621fb0846baa4278e1b3e00ff6eee279cb8e540fab'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/stunnel-5.42-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/stunnel-5.42-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/stunnel-5.42-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/stunnel-5.42-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6d16c4bec0d34b70aeea87c50523082cd237c1f453804adc094add3c0811e7d8',
     armv7l: '6d16c4bec0d34b70aeea87c50523082cd237c1f453804adc094add3c0811e7d8',
       i686: 'cf9d32c8abf695a786c7b0dfe5573b1dc5355e2f45b3eb7d1979012532f7c5c9',
     x86_64: '35876775273e30f179df5966c0444c3a7290d22d668a81c83959ba6c8a644a2f',
  })

  depends_on 'openssl'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
