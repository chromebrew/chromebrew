# Adapted from Arch Linux ldb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ldb/trunk/PKGBUILD

require 'package'

class Ldb < Package
  description 'Schema-less, ldap like, API and database'
  homepage 'https://ldb.samba.org/'
  version '2.5.0'
  license 'GPLv3'
  compatibility 'all'
  source_url "https://samba.org/ftp/ldb/ldb-#{version}.tar.gz"
  source_sha256 '583ec548fc9cac4596dcd8b510408cdda2a8f85c02e672d0f9dce6a7364faa5e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.5.0_armv7l/ldb-2.5.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.5.0_armv7l/ldb-2.5.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.5.0_i686/ldb-2.5.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.5.0_x86_64/ldb-2.5.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c07b01c496e6ec532e654ca9d7f22aeca3d8ef79645ada44fd6457b4a64f4bb7',
     armv7l: 'c07b01c496e6ec532e654ca9d7f22aeca3d8ef79645ada44fd6457b4a64f4bb7',
       i686: 'd0de89fd2485e5963f9ee7f0626c2057fc8b52685003963ab75ce43f4c06d08b',
     x86_64: '5e714041f50e093916d5ec22760b40342dee7340ddd75cf3f0952dcc3e6e03ad'
  })

  depends_on 'cmocka' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'libbsd'
  depends_on 'libxcrypt'
  depends_on 'lmdb'
  depends_on 'popt'
  depends_on 'talloc'
  depends_on 'tdb'
  depends_on 'tevent'

  def self.build
    system "./configure \
      #{CREW_OPTIONS.sub(/--program-suffix.*/, '')} \
      --localstatedir=#{CREW_PREFIX}/var \
      --sysconfdir=#{CREW_PREFIX}/etc/samba \
      --with-modulesdir=#{CREW_LIB_PREFIX}/ldb/modules \
      --with-privatelibdir=#{CREW_LIB_PREFIX}/ldb"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
