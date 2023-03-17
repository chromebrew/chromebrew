require 'package'

class Gnupg < Package
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.4.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://dev.gnupg.org/source/gnupg.git'
  git_hashtag "gnupg-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.4.0_armv7l/gnupg-2.4.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.4.0_armv7l/gnupg-2.4.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.4.0_i686/gnupg-2.4.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.4.0_x86_64/gnupg-2.4.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7edfb36d3c4e1582f45bd2d440724bb6cb209bec531ca94a79079c9d2c61c72f',
     armv7l: '7edfb36d3c4e1582f45bd2d440724bb6cb209bec531ca94a79079c9d2c61c72f',
       i686: 'ca593d760edc42959c41006aa7c551085502ded7d87ae59138b6201c00b533a5',
     x86_64: 'a50c6c329dde303cd179f19bfbc4df6ef2436c213ccc0812ab5a4a1b88b870ee'
  })

  depends_on 'bz2' # R
  depends_on 'fig2dev' => :build
  depends_on 'imagemagick7' => :build
  depends_on 'libassuan' # R
  depends_on 'libgcrypt' # R
  depends_on 'libksba' # R
  depends_on 'libusb' # R
  depends_on 'npth' # R
  depends_on 'pinentry' => :build
  depends_on 'potrace' => :build
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'libgpgerror' # R
  depends_on 'libusb' # R
  depends_on 'npth' # R
  depends_on 'openldap' # R
  depends_on 'readline' # R
  depends_on 'sqlite' # R
  depends_on 'zlibpkg' # R

  def self.build
    system './autogen.sh --force'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --enable-maintainer-mode \
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
    system 'make check || true'
  end
end
