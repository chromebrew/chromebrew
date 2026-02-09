# Adapted from Arch Linux ldb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ldb/trunk/PKGBUILD

require 'package'

class Ldb < Package
  description 'Schema-less, ldap like, API and database'
  homepage 'https://ldb.samba.org/'
  version "2.9.2-#{CREW_PY_VER}"
  license 'GPLv3'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/ldb/ldb-#{version.split('-').first}.tar.gz"
  source_sha256 'd155884002c79dbb1c3d8642f8b1013f2e520b3aeefd6e96412adec5b8d6cbc0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '345b5c1720f4b68093f1a0c38b44cc4a6a0136a2344fab97da24827954e3dabe',
     armv7l: '345b5c1720f4b68093f1a0c38b44cc4a6a0136a2344fab97da24827954e3dabe',
       i686: 'c5fb335c4950b91cec0808e0919599e3d3ea090224a23f3a857af16e75bce3d3',
     x86_64: '82afef5038862dff2dfd2e2b6b0e10ebedf38b24e1c2c7caabca2267cec5f3d8'
  })

  depends_on 'cmocka' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdb' => :build
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
      #{CREW_CONFIGURE_OPTIONS.sub(/--program-suffix.*/, '')} \
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
