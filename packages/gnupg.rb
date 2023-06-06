require 'package'

class Gnupg < Package
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.4.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.4.2.tar.bz2'
  source_sha256 '97eb47df8ae5a3ff744f868005a090da5ab45cb48ee9836dbf5ee739a4e5cf49'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.4.2_armv7l/gnupg-2.4.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.4.2_armv7l/gnupg-2.4.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.4.2_i686/gnupg-2.4.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.4.2_x86_64/gnupg-2.4.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8273becdcaf93b59b92fb22919dc01128c6b9cf698194ae7f48fa17829a18595',
     armv7l: '8273becdcaf93b59b92fb22919dc01128c6b9cf698194ae7f48fa17829a18595',
       i686: '1b7a96fd611db999496c6ab08f92611cd9026c8f8d3a10bce57bcdb6ebcbc912',
     x86_64: '74e68626a4bcbd1d4145d9699c06d695172d93dfcb91fdcd627eeb9f22482426'
  })

  depends_on 'bz2' # R
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'libassuan' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpgerror' # R
  depends_on 'libksba' # R
  depends_on 'libusb' # R
  depends_on 'libxtrans' => :build
  depends_on 'npth' # R
  depends_on 'openldap' # R
  depends_on 'pinentry' => :build
  depends_on 'potrace' => :build
  depends_on 'readline' # R
  depends_on 'sqlite' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
              --enable-maintainer-mode \
              --with-zlib \
              --with-bzip2 \
              --with-readline"
    system "make -j #{CREW_NPROC} || make -j 1"
  end

  def self.check
    system 'make check || true'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
