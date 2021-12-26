require 'package'

class Gnupg < Package
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.3.4'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.3.4.tar.bz2'
  source_sha256 'f3468ecafb1d7f9ad7b51fd1db7aebf17ceb89d2efa8a05cf2f39b4d405402ae'

  depends_on 'bz2'
  depends_on 'libassuan'
  depends_on 'libgcrypt'
  depends_on 'libksba'
  depends_on 'pinentry'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --enable-all-tests \
              --with-capabilities \
              --with-zlib \
              --with-bzip2 \
              --with-readline"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
