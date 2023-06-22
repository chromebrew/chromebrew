require 'package'

class Gpgme < Package
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  version '1.17.1'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-#{version}.tar.bz2"
  source_sha256 '711eabf5dd661b9b04be9edc9ace2a7bc031f6bd9d37a768d02d0efdef108f5f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gpgme/1.17.1_armv7l/gpgme-1.17.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gpgme/1.17.1_armv7l/gpgme-1.17.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gpgme/1.17.1_i686/gpgme-1.17.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gpgme/1.17.1_x86_64/gpgme-1.17.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7f18875986e440ba0a1d6c6fef977f4235efcbad9f390772b9d2f292f3b20700',
     armv7l: '7f18875986e440ba0a1d6c6fef977f4235efcbad9f390772b9d2f292f3b20700',
       i686: '6c54ea2784966e5ad972c53b53d63b1514036013fc698f75f36195b3d77fc434',
     x86_64: '324529721ce4dbe10d971629bfa9f6a25c1a9040645b38b664c4f805987d2524'
  })

  depends_on 'gnupg'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
