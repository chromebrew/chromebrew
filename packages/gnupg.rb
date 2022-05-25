require 'package'

class Gnupg < Package
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.4.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.4.3.tar.bz2'
  source_sha256 'a271ae6d732f6f4d80c258ad9ee88dd9c94c8fdc33c3e45328c4d7c126bd219d'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.4.3_armv7l/gnupg-2.4.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.4.3_armv7l/gnupg-2.4.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.4.3_i686/gnupg-2.4.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.4.3_x86_64/gnupg-2.4.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '63cce56c35ff714e0c697f720b33158461b7ee869c2cd6c23c83fa0350eadb6f',
     armv7l: '63cce56c35ff714e0c697f720b33158461b7ee869c2cd6c23c83fa0350eadb6f',
       i686: '5bde4e918c1e8122e50ce20181743bd8758a516eda29558f423904aa15f6fe9f',
     x86_64: '479dad1509044aa77ebb3b6648ab54d0fcc298376df9b5fc960f4d1390b277f0'
  })

  depends_on 'bzip2' # R
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
