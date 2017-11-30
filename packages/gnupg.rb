require 'package'

class Gnupg < Package
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.2.2'
  source_url 'https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.2.tar.bz2'
  source_sha256 'bfb62c7412ceb3b9422c6c7134a34ff01a560f98eb981c2d96829c1517c08197'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnupg-2.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '469b4f0abbdc7dda28a0f1b900cbc75d48ab829845a2cceed279aa6dbc7596ce',
     armv7l: '469b4f0abbdc7dda28a0f1b900cbc75d48ab829845a2cceed279aa6dbc7596ce',
       i686: 'f4e61eed1efb7cbe9bf2d56973dac877c2a780cb6f57ce46a5946c7d06e239c4',
     x86_64: '541012cd8afcf0c122b8beadb0ed40fc568bc134f01608aaa1648cd36a0a3f15',
  })

  depends_on 'bz2'
  depends_on 'automake'
  depends_on 'libgpgerror'
  depends_on 'libgcrypt'
  depends_on 'libassuan'
  depends_on 'libksba'
  depends_on 'npth'
  depends_on 'gettext'

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
