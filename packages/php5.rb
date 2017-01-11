require 'package'

class Php5 < Package
  version '5.6.29'
  source_url 'http://php.net/distributions/php-5.6.29.tar.xz' # software source tarball url
  source_sha1 'df3301d11d56fbeabd8f6336e9c8f4c47af45562'     # source tarball sha1 sum

  depends_on 'libxml2'
  depends_on 'openssl'
  depends_on 'libpng'

  def self.build                                             # self.build contains commands needed to build the software from source
    system "./configure \
      --with-curl \
      --with-gd \
      --enable-mbstring \
      --with-ssl=/usr/local/bin/openssl \
      --with-zlib \
      --with-pcre-regex \
      --prefix=/usr/local"
    system 'make'                                            # ordered chronologically
  end

  def self.install                                           # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"     # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end
end
