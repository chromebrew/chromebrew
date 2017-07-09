require 'package'

class Libxslt < Package
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'http://xmlsoft.org/libxslt/'
  version '1.1.28-2'
  source_url 'http://xmlsoft.org/sources/libxslt-1.1.28.tar.gz'
  source_sha256 '5fc7151a57b89c03d7b825df5a0fae0a8d5f05674c0e7cf2937ecec4d54a028c'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libxslt-1.1.28-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libxslt-1.1.28-2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libxslt-1.1.28-2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libxslt-1.1.28-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7ad046e453a7176bc9ed22a62b13cf8e71796d51c04915487189133224c2c7c6',
     armv7l: '7ad046e453a7176bc9ed22a62b13cf8e71796d51c04915487189133224c2c7c6',
       i686: 'f80b88b711a404d14d21bd427d855b31466318833bdbdb5c3e2ac4a7440a3523',
     x86_64: 'da9d8b911a30908a3bc9df81a70132115848333d9f7c7c82e5cb2c74999e8fb4',
  })

  depends_on 'libxml2'

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
