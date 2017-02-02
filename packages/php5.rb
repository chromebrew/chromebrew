require 'package'

class Php5 < Package
  version '5.6.29'
  source_url 'http://php.net/distributions/php-5.6.29.tar.xz'  # software source tarball url
  source_sha1 'df3301d11d56fbeabd8f6336e9c8f4c47af45562'       # source tarball sha1 sum

  depends_on 'pkgconfig'                                       # add package dependencies
  depends_on 'zlibpkg'
  depends_on 'libpng'
  depends_on 'libxml2'
  depends_on 'openssl'
  depends_on 'curl'
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
