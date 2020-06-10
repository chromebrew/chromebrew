require 'package'

class Gpgme < Package
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  version '1.11.1'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-1.11.1.tar.bz2'
  source_sha256 '2d1b111774d2e3dd26dcd7c251819ce4ef774ec5e566251eb9308fa7542fbd6f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gpgme-1.11.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gpgme-1.11.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gpgme-1.11.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gpgme-1.11.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8d4ba8c7327038226808c7399a73e1f1b36060a72a52578f7f659fe214a87746',
     armv7l: '8d4ba8c7327038226808c7399a73e1f1b36060a72a52578f7f659fe214a87746',
       i686: 'f659ac710ffcd4c6f3738af64a358af2f1053e411964629a0d6e40d221d436ef',
     x86_64: 'e875258d9fcc951237149d954b549a45f384a6b23e2c596ec555f761b7600035',
  })

  depends_on 'gnupg'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
