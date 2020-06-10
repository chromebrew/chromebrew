require 'package'

class Libassuan < Package
  description 'Libassuan is a small library implementing the so-called Assuan protocol.'
  homepage 'https://www.gnupg.org/related_software/libassuan/index.html'
  version '2.5.1'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.1.tar.bz2'
  source_sha256 '47f96c37b4f2aac289f0bc1bacfa8bd8b4b209a488d3d15e2229cb6cc9b26449'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libassuan-2.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libassuan-2.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libassuan-2.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libassuan-2.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7ef02236dc8e6fceeda62f30e49fdc449a53d3c5de40ee023e95572dc8cbc6c7',
     armv7l: '7ef02236dc8e6fceeda62f30e49fdc449a53d3c5de40ee023e95572dc8cbc6c7',
       i686: 'bc8b79f18b73b3b02f11ba4ab36e8240572e94a07d109ede33e38187ae0bd51f',
     x86_64: 'e02c94c283f9b685327456a0b964050db456186fe86298ada238a02a356766cb',
  })

  depends_on 'libgpgerror'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
