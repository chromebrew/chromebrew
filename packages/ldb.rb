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
    aarch64: 'b12820807d572e792692b56116edc64c579254287c99d3097b3e0eb65eabb540',
     armv7l: 'b12820807d572e792692b56116edc64c579254287c99d3097b3e0eb65eabb540',
       i686: '38e3cd51346b36c83467b5f5cd04db47d8445fcd11fe0dcbc0ba370f6678f90b',
     x86_64: '7efacb9a2a2341f4d2d76e4dde61f5846943a0a496c5586c78a73457e76b33c1'
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
