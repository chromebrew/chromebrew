require 'package'

class Php7 < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '7.1.12'
  source_url 'https://php.net/distributions/php-7.1.12.tar.xz'
  source_sha256 'a0118850774571b1f2d4e30b4fe7a4b958ca66f07d07d65ebdc789c54ba6eeb3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fa1a0897dd78ea1cf94bc353a78e56e15789f7705babaabdee8c353f651ae89a',
     armv7l: 'fa1a0897dd78ea1cf94bc353a78e56e15789f7705babaabdee8c353f651ae89a',
       i686: '6fbea0ee47680e4f08e61712e6a2aa8128af7987e8fe20c4458a6b988458e213',
     x86_64: '78fa2609dd43dea42c62436551ec9b3efba1e037dd8e983f68ab81636f4b10b9',
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
