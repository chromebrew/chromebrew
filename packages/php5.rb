require 'package'

class Php5 < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.34'
  source_url 'http://php.net/distributions/php-5.6.34.tar.xz'
  source_sha256 '21453be3a045204cd2717543ef42771324f411f40962ecda4fe841930a933128'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.34-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.34-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.34-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.34-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '21f7c51091347184fa94f298d229e7cd60892e4a5286d65b03443c1847105741',
     armv7l: '21f7c51091347184fa94f298d229e7cd60892e4a5286d65b03443c1847105741',
       i686: 'e0964018f1b9e26c0c3979ab062c6d7d4b10a90971a7c8f7d434ab11847fb21f',
     x86_64: '987c1b2a993ad2da290e356bc9d853f8be7ea401b9c4d8925c7e4c294174df1c',
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
