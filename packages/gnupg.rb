require 'package'

class Gnupg < Package
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.2.5'
  source_url 'https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.5.tar.bz2'
  source_sha256 '3fa189a32d4fb62147874eb1389047c267d9ba088f57ab521cb0df46f08aef57'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'automake' => :build
  depends_on 'bz2'
  depends_on 'libgpgerror'
  depends_on 'libgcrypt'
  depends_on 'libassuan'
  depends_on 'libksba'
  depends_on 'npth'
  depends_on 'gettext'
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
