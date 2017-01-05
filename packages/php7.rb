require 'package'

class Php7 < Package
  version '7.1.0'
  source_url 'http://php.net/distributions/php-7.1.0.tar.xz'   # software source tarball url
  source_sha1 'c74c920256b9c6873bae696fbb0ec14a02dc8495'       # source tarball sha1 sum

  depends_on 'curl'
  depends_on 'libpng'
  depends_on 'libxml2'
  depends_on 'openssl'
  depends_on 'pcre'

  def self.build                                               # self.build contains commands needed to build the software from source
    system './configure \
      --prefix=/usr/local \
      --with-curl \
      --with-gd \
      --enable-mbstring \
      --with-openssl \
      --with-pcre-regex \
      --with-zlib'
    system 'make'                                              # ordered chronologically
  end

  def self.install                                             # self.install contains commands needed to install the software on the target system
    system "make", "INSTALL_ROOT=#{CREW_DEST_DIR}", "install"  # remember to include INSTALL_ROOT set to CREW_DEST_DIR - needed to keep track of changes made to system

    # clean up some files created under #{CREW_DEST_DIR}. check http://pear.php.net/bugs/bug.php?id=20383 for more details
    system "mv", "#{CREW_DEST_DIR}/.depdb", "#{CREW_DEST_DIR}/usr/local/lib/php"
    system "mv", "#{CREW_DEST_DIR}/.depdblock", "#{CREW_DEST_DIR}/usr/local/lib/php"
    system "rm", "-rf", "#{CREW_DEST_DIR}/.channels", "#{CREW_DEST_DIR}/.filemap", "#{CREW_DEST_DIR}/.lock", "#{CREW_DEST_DIR}/.registry"
  end
end
