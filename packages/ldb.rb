# Adapted from Arch Linux ldb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ldb/trunk/PKGBUILD

require 'package'

class Ldb < Package
  description 'Schema-less, ldap like, API and database'
  homepage 'https://ldb.samba.org/'
  version "2.9.2-#{CREW_PY_VER}"
  license 'GPLv3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.samba.org/ftp/ldb/ldb-#{version.split('-').first}.tar.gz"
  source_sha256 'd155884002c79dbb1c3d8642f8b1013f2e520b3aeefd6e96412adec5b8d6cbc0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0cbe3037f30a80879978d73c3aba628c2ff9d3a8d3158c79dc8fd426a7ac2586',
     armv7l: '0cbe3037f30a80879978d73c3aba628c2ff9d3a8d3158c79dc8fd426a7ac2586',
     x86_64: '5d867bee58a28cef411ea02a748051d7968835ad3406e44156bbe208470750b5'
  })

  depends_on 'cmocka' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'gdb' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libbsd' => :library
  depends_on 'libxcrypt' => :build
  depends_on 'lmdb' => :library
  depends_on 'openldap' => :library
  depends_on 'popt' => :library
  depends_on 'python3' => :library
  depends_on 'talloc' => :library
  depends_on 'tdb' => :library
  depends_on 'tevent' => :library

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
