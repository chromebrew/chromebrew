require 'package'

class Gpgme < Package
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  @_ver = '1.17.0'
  version @_ver
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-#{@_ver}.tar.bz2"
  source_sha256 '4ed3f50ceb7be2fce2c291414256b20c9ebf4c03fddb922c88cda99c119a69f5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gpgme/1.17.0_armv7l/gpgme-1.17.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gpgme/1.17.0_armv7l/gpgme-1.17.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gpgme/1.17.0_i686/gpgme-1.17.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gpgme/1.17.0_x86_64/gpgme-1.17.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '37a3825a92c97935d1ec0aec7551ec0daae0c314db0428c6bba752ffd66e7c4c',
     armv7l: '37a3825a92c97935d1ec0aec7551ec0daae0c314db0428c6bba752ffd66e7c4c',
       i686: '6331885eac641a14e0bc47b9d01cc75a093b67acce0291e143e91345952ea486',
     x86_64: 'dbe4671b83a5bae3696abc15f50ee6cb8226c11379d7f8a444a2d23aa8e754a4'
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
