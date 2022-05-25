# Adapted from Arch Linux ldb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ldb/trunk/PKGBUILD

require 'package'

class Ldb < Package
  description 'Schema-less, ldap like, API and database'
  homepage 'https://ldb.samba.org/'
  @_ver = '2.8.0'
  version "#{@_ver}-py3.12"
  license 'GPLv3'
  compatibility 'all'
  source_url "https://samba.org/ftp/ldb/ldb-#{@_ver}.tar.gz"
  source_sha256 '358dca10fcd27207ac857a0d7f435a46dbc6cd1f7c10dbb840c1931bf1965f08'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.8.0-py3.12_armv7l/ldb-2.8.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.8.0-py3.12_armv7l/ldb-2.8.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.8.0-py3.12_i686/ldb-2.8.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.8.0-py3.12_x86_64/ldb-2.8.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ae5e14c6e4a8cbdf1391d6c52e162518a862841077648d76b14aac80a02a1619',
     armv7l: 'ae5e14c6e4a8cbdf1391d6c52e162518a862841077648d76b14aac80a02a1619',
       i686: 'ab3b4d8372ef4acbe59596ff6d1dea35989ac96ee2988198fd2d5754788ce3a5',
     x86_64: '376caa065ca00aa19791fe4c86b2ea04c5120833d1c3af26230fc95d580db3e8'
  })

  depends_on 'cmocka' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxcrypt' => :build
  depends_on 'lmdb' # R
  depends_on 'openldap' # R
  depends_on 'popt' # R
  depends_on 'python3' # R
  depends_on 'talloc' # R
  depends_on 'tdb' # R
  depends_on 'tevent' # R

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
