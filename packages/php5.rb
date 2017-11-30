require 'package'

class Php5 < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.32'
  source_url 'http://php.net/distributions/php-5.6.32.tar.xz'
  source_sha256 '8c2b4f721c7475fb9eabda2495209e91ea933082e6f34299d11cba88cd76e64b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.32-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.32-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.32-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.32-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '95eb2d46dd04f3690063df002397e085bffb7bc8a6275c495fe3bea23f41dbfa',
     armv7l: '95eb2d46dd04f3690063df002397e085bffb7bc8a6275c495fe3bea23f41dbfa',
       i686: 'aa5af655b82610cc11a1f1343d6fc796a0d9e6d70706974d1d8dc8f2667b6f48',
     x86_64: '4895c65b7e8eaaf2814b5a76fdbd8cd532821df241163288f9e635427e1c27b7',
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
    system "./configure \
      --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX} \
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
