# Adapted from Arch Linux ldb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ldb/trunk/PKGBUILD

require 'package'

class Ldb < Package
  description 'Schema-less, ldap like, API and database'
  homepage 'https://ldb.samba.org/'
  @_ver = '2.7.1'
  version "#{@_ver}-py3.11"
  license 'GPLv3'
  compatibility 'all'
  source_url "https://samba.org/ftp/ldb/ldb-#{@_ver}.tar.gz"
  source_sha256 'c4632c9a7f81f8a45ed46fc14d18eb507edf4e79f6e88d16977478ef95ed5b7f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.7.1-py3.11_armv7l/ldb-2.7.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.7.1-py3.11_armv7l/ldb-2.7.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.7.1-py3.11_i686/ldb-2.7.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ldb/2.7.1-py3.11_x86_64/ldb-2.7.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '40e359e72bf1046b11041574031a84d9d62395ccad88cd1e8c822278d5b8db20',
     armv7l: '40e359e72bf1046b11041574031a84d9d62395ccad88cd1e8c822278d5b8db20',
       i686: 'a10ee878eb6dbbab2d3c253167d62b444dcd0e69019b0e09f6a17b400f7348d0',
     x86_64: 'f3709bc212eb23f835b530c7d277ac843d4717eea057108d7d28cade88e30a1c'
  })

  depends_on 'cmocka' => :build
  depends_on 'docbook_xsl' => :build
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
