# Adapted from Arch Linux ldb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ldb/trunk/PKGBUILD

require 'package'

class Ldb < Package
  description 'Schema-less, ldap like, API and database'
  homepage 'https://ldb.samba.org/'
  @_ver = '2.9.0'
  version "#{@_ver}-py3.12"
  license 'GPLv3'
  compatibility 'all'
  source_url "https://samba.org/ftp/ldb/ldb-#{@_ver}.tar.gz"
  source_sha256 '105aaff71ad881a7faeb582fd416ae28221b6fde338fff82828065062c2507a5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f355683fe450dbb30a34904ee85abef2d7895907897f03133f74a853100c6f0',
     armv7l: '4f355683fe450dbb30a34904ee85abef2d7895907897f03133f74a853100c6f0',
       i686: '6af6a1202c85b38cab2fdeb47138f7c124b17c7639dff3cbac10bfff15fc4c76',
     x86_64: '1c1743b78c2b12a9f69d287bc2fbcc127d91111286a25cd2e35090039e8245df'
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
