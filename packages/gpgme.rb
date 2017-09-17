require 'package'

class Gpgme < Package
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  version '1.9.0'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-1.9.0.tar.bz2'
  source_sha256 '1b29fedb8bfad775e70eafac5b0590621683b2d9869db994568e6401f4034ceb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gpgme-1.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gpgme-1.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gpgme-1.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gpgme-1.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '759ff099b5540be347291b4b8efb12560272e81af8b6b05b0b9d1806789cd4cb',
     armv7l: '759ff099b5540be347291b4b8efb12560272e81af8b6b05b0b9d1806789cd4cb',
       i686: '4a410cb150dafad7f78b930b45d2999129a251c949b4711f47ea2688d30ea04a',
     x86_64: 'fcb3d155785a0a603f0dfee377f7e2ba2cda057b69d61a632c5cdaa14814804e',
  })

  depends_on 'libgpgerror'
  depends_on 'libassuan'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
