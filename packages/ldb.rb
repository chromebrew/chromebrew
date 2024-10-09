# Adapted from Arch Linux ldb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ldb/trunk/PKGBUILD

require 'package'

class Ldb < Package
  description 'Schema-less, ldap like, API and database'
  homepage 'https://ldb.samba.org/'
  version "2.9.1-#{CREW_PY_VER}"
  license 'GPLv3'
  compatibility 'all'
  source_url "https://samba.org/ftp/ldb/ldb-#{version.split('-').first}.tar.gz"
  source_sha256 'c95e4dc32dea8864b79899ee340c9fdf28b486f464bbc38ba99151a08b493f9b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '329039c021a28eeec1724ce00792262a6b7077a728b64fd766c784090daed756',
     armv7l: '329039c021a28eeec1724ce00792262a6b7077a728b64fd766c784090daed756',
       i686: '41a64479efa5a4e84eb760a5a099a5aee385709097306b84b6335bffaeb223d7',
     x86_64: 'c51584480e0fd33624eb33c42994d38418ccf2e0f01ceb9cdc8d610e1070263c'
  })

  depends_on 'cmocka' => :build
  depends_on 'docbook_xsl' => :build
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
