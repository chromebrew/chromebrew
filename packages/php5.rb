require 'package'

class Php5 < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.31'
  source_url 'http://php.net/distributions/php-5.6.31.tar.xz'
  source_sha256 'c464af61240a9b7729fabe0314cdbdd5a000a4f0c9bd201f89f8628732fe4ae4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.31-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.31-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.31-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.31-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'aeca560c546742d3204b65148f3a8da748e4f3228e3e24a9d8779ce8e44195dd',
     armv7l: 'aeca560c546742d3204b65148f3a8da748e4f3228e3e24a9d8779ce8e44195dd',
       i686: '88423ffa51e79a7377bb85c94600513428d2f0505d1fa6522598a678c6546666',
     x86_64: '10a66b8ebe73dfd60f8c194664746330274c033564259f345c802de173c88cf7',
  })

  depends_on 'pkgconfig'
  depends_on 'zlibpkg'
  depends_on 'libpng'
  depends_on 'libxml2'
  depends_on 'libxslt'
  depends_on 'openssl'
  depends_on 'curl'
  depends_on 'pcre'
  depends_on 'readline'

  def self.build
    system './configure \
      --prefix=/usr/local \
      --with-curl \
      --with-gd \
      --with-xsl \
      --enable-mbstring \
      --with-openssl \
      --with-pcre-regex \
      --with-readline \
      --with-zlib'
    system 'make'
  end

  def self.install
    system "make", "INSTALL_ROOT=#{CREW_DEST_DIR}", "install"

    # clean up some files created under #{CREW_DEST_DIR}. check http://pear.php.net/bugs/bug.php?id=20383 for more details
    system "mv", "#{CREW_DEST_DIR}/.depdb", "#{CREW_DEST_DIR}/usr/local/lib/php"
    system "mv", "#{CREW_DEST_DIR}/.depdblock", "#{CREW_DEST_DIR}/usr/local/lib/php"
    system "rm", "-rf", "#{CREW_DEST_DIR}/.channels", "#{CREW_DEST_DIR}/.filemap", "#{CREW_DEST_DIR}/.lock", "#{CREW_DEST_DIR}/.registry"
  end
end
