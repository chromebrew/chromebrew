require 'package'

class Gnupg < Package
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.2.7'
  compatibility 'all'
  source_url 'https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.7.tar.bz2'
  source_sha256 'd95b361ee6ef7eff86af40c8c72bf9313736ac9f7010d6604d78bf83818e976e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e356625feaef9e93d4d0946635db862df13c5f555636b38c5504042fa4ff3c23',
     armv7l: 'e356625feaef9e93d4d0946635db862df13c5f555636b38c5504042fa4ff3c23',
       i686: '32060d1d69ac5b44ad7f7fe7e6a2744404f972b26b28ba2999e70c12f9c20dc7',
     x86_64: 'eaa2a33957ce00de10e0655b326ba1d2d9512b749e1d81cbf205c4c6e064a729',
  })

  depends_on 'bz2'
  depends_on 'libassuan'
  depends_on 'libgcrypt'
  depends_on 'libksba'
  depends_on 'pinentry'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
