# Adapted from Arch Linux ldb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ldb/trunk/PKGBUILD

require 'package'

class Ldb < Package
  description 'Schema-less, ldap like, API and database'
  homepage 'https://ldb.samba.org/'
  version '2.3.0'
  license 'GPLv3'
  compatibility 'all'
  source_url "https://samba.org/ftp/ldb/ldb-#{version}.tar.gz"
  source_sha256 'a4d308b3d0922ef01f3661a69ebc373e772374defa76cf0979ad21b21f91922d'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/ldb-2.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/ldb-2.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/ldb-2.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/ldb-2.3.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a21f075d2ecc39ccb53e97433c4cdbe3474054f773ea31735c9ef1227e05ae9e',
     armv7l: 'a21f075d2ecc39ccb53e97433c4cdbe3474054f773ea31735c9ef1227e05ae9e',
       i686: '4f4e782aa74c6ff93f20c0ab13858ea295094e547169336ec3d0cc34e6e1b3d2',
     x86_64: '509439aae3a82f99825414bac49b704d6fec0f95c67e8b2532001e011ce2d288'
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
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
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
