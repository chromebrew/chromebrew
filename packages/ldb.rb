# Adapted from Arch Linux ldb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ldb/trunk/PKGBUILD

require 'package'

class Ldb < Package
  description 'Schema-less, ldap like, API and database'
  homepage 'https://ldb.samba.org/'
  version '2.9.1-py3.12'
  license 'GPLv3'
  compatibility 'all'
  source_url "https://samba.org/ftp/ldb/ldb-#{version.split('-').first}.tar.gz"
  source_sha256 '105aaff71ad881a7faeb582fd416ae28221b6fde338fff82828065062c2507a5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '78ec3789e72251b4439325dac0c5ce6137e5787df52cfdadd591d9ccafba7382',
     armv7l: '78ec3789e72251b4439325dac0c5ce6137e5787df52cfdadd591d9ccafba7382',
       i686: '41a64479efa5a4e84eb760a5a099a5aee385709097306b84b6335bffaeb223d7',
     x86_64: '48f44065d72deb20771736cfbfe802fe668736a01ec776c8a710d8ba12db09b0'
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
