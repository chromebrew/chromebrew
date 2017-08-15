require 'package'

class Php7 < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '7.1.8'
  source_url 'https://php.net/distributions/php-7.1.8.tar.xz'
  source_sha256 '8943858738604acb33ecedb865d6c4051eeffe4e2d06f3a3c8f794daccaa2aab'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/php7-7.1.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/php7-7.1.8-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/php7-7.1.8-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/php7-7.1.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '189dd7432d81613f46c36df7e833308fa4c4dfd42930fbb8ee259c7e5acdd2bc',
     armv7l: '189dd7432d81613f46c36df7e833308fa4c4dfd42930fbb8ee259c7e5acdd2bc',
       i686: 'e7af55ce2d1330b2078259e67a6437ff08b78134b5db7c2acb919265eb8bf02a',
     x86_64: '0ed419400ca523f36d428e0aa778813274d4faf7554a5fcf3eab2d811c031414',
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
      --docdir=/usr/local/doc \
      --infodir=/usr/local/info \
      --mandir=/usr/local/man \
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
