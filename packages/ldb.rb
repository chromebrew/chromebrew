# Adapted from Arch Linux ldb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ldb/trunk/PKGBUILD

require 'package'

class Ldb < Package
  description 'Schema-less, ldap like, API and database'
  homepage 'https://ldb.samba.org/'
  version '2.5.2'
  license 'GPLv3'
  compatibility 'all'
  source_url "https://samba.org/ftp/ldb/ldb-#{version}.tar.gz"
  source_sha256 '6fada72274b648799d33f851d9edbbb1b31389910c207e111b597f97bf83a0e4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.5.2_armv7l/ldb-2.5.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.5.2_armv7l/ldb-2.5.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.5.2_i686/ldb-2.5.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.5.2_x86_64/ldb-2.5.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '57f2e721b730b444473d6ccb66e4d5c15a472f59f0c717febae4a70770844472',
     armv7l: '57f2e721b730b444473d6ccb66e4d5c15a472f59f0c717febae4a70770844472',
       i686: '5a66f1dda57ea412737b74801d9f169a164d5247c9a0baca64a15dc52a0ee0f0',
     x86_64: '8bb8be2f0274e8938cd30a27d7faae28cc00819cec978ae4ee1ced75026972ac'
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
