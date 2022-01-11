require 'package'

class Libksba < Package
  description 'Libksba is a library to make the tasks of working with X.509 certificates, CMS data and related objects more easy.'
  homepage 'https://www.gnupg.org/related_software/libksba/index.html'
  version '1.6.0'
  license 'LGPL-3+, GPL-2+ and GPL-3+'
  compatibility 'all'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libksba/libksba-1.6.0.tar.bz2'
  source_sha256 'dad683e6f2d915d880aa4bed5cea9a115690b8935b78a1bbe01669189307a48b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libksba/1.6.0_armv7l/libksba-1.6.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libksba/1.6.0_armv7l/libksba-1.6.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libksba/1.6.0_i686/libksba-1.6.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libksba/1.6.0_x86_64/libksba-1.6.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd25ccbccc0a376b5a832167dadf95295117feb63b52020438e301e3f2d6eca66',
     armv7l: 'd25ccbccc0a376b5a832167dadf95295117feb63b52020438e301e3f2d6eca66',
       i686: 'db9c4cccfa6452890cfcd2c90155a097cc8c24ff884eacb2377364b437a3d3ce',
     x86_64: '1306f097b8a500d4bd39442329083fd79cceb8fd62a7b159466b6acef9ad8839'
  })

  depends_on 'libgpgerror'
  depends_on 'npth'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
