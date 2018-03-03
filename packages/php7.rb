require 'package'

class Php7 < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '7.2.3'
  source_url 'https://php.net/distributions/php-7.2.3.tar.xz'
  source_sha256 'b3a94f1b562f413c0b96f54bc309706d83b29ac65d9b172bc7ed9fb40a5e651f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '076113ce15e8e5f0e2176924d296a9b936fa6e269e2b6d9e9ca2b2b3493f5267',
     armv7l: '076113ce15e8e5f0e2176924d296a9b936fa6e269e2b6d9e9ca2b2b3493f5267',
       i686: 'c8ee47aee521aa13748e0d0a701fd67c8a4aae98a3a8b05aa4fdf01e3b0eb9c4',
     x86_64: 'd38bc3cd1ddbc24c9803aac7d30dfdf1620e67f83b3feeb142ec4bdb35deb825',
  })

  depends_on 'pkgconfig'
  depends_on 'zlibpkg'
  depends_on 'libgcrypt'
  depends_on 'libpng'
  depends_on 'libxml2'
  depends_on 'libxslt'
  depends_on 'openssl'
  depends_on 'curl'
  depends_on 'pcre'
  depends_on 'readline'

  def self.build
    system "./configure \
      --prefix=#{CREW_PREFIX} \
      --docdir=#{CREW_PREFIX}/doc \
      --infodir=#{CREW_PREFIX}/info \
      --libdir=#{CREW_LIB_PREFIX} \
      --localstatedir=#{CREW_PREFIX}/tmp \
      --mandir=#{CREW_PREFIX}/man \
      --with-curl \
      --with-gd \
      --with-xsl \
      --enable-mbstring \
      --with-openssl \
      --with-pcre-regex \
      --with-readline \
      --with-zlib"
    system 'make'
  end

  def self.install
    system "make", "INSTALL_ROOT=#{CREW_DEST_DIR}", "install"

    # clean up some files created under #{CREW_DEST_DIR}. check http://pear.php.net/bugs/bug.php?id=20383 for more details
    system "mv", "#{CREW_DEST_DIR}/.depdb", "#{CREW_DEST_LIB_PREFIX}/php"
    system "mv", "#{CREW_DEST_DIR}/.depdblock", "#{CREW_DEST_LIB_PREFIX}/php"
    system "rm", "-rf", "#{CREW_DEST_DIR}/.channels", "#{CREW_DEST_DIR}/.filemap", "#{CREW_DEST_DIR}/.lock", "#{CREW_DEST_DIR}/.registry"
  end
end
