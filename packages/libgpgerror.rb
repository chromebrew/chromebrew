require 'package'

class Libgpgerror < Package
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.26'
  source_url 'ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-1.26.tar.bz2'
  source_sha256 '4c4bcbc90116932e3acd37b37812d8653b1b189c1904985898e860af818aee69'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.26-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.26-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.26-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgpgerror-1.26-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8519fc31c49191fc2e59fd77914c09855352fcefa4492803c2c26ec602e219ec',
     armv7l: '8519fc31c49191fc2e59fd77914c09855352fcefa4492803c2c26ec602e219ec',
       i686: '906a9439e04955d6883b6cbef7d98a4d4c4224f55bcdee410e316e2e2169137b',
     x86_64: 'f3f0d5128776ab8aa21387dab1d257a8543cf9eca06ee9001427092d0ebd9849',
  })

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
