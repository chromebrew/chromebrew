require 'package'

class Php70 < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '7.0.33'
  source_url 'https://php.net/distributions/php-7.0.33.tar.xz'
  source_sha256 'ab8c5be6e32b1f8d032909dedaaaa4bbb1a209e519abb01a52ce3914f9a13d96'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.33-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.33-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.33-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.33-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4b1a64041ce564014c9318ec4697796c783caac0689489c21f90d41d338dc753',
     armv7l: '4b1a64041ce564014c9318ec4697796c783caac0689489c21f90d41d338dc753',
       i686: 'adce0459926b85882ee5d2dd5801a4d062eec3f63abf893a12da9a30a8b4d738',
     x86_64: 'a55e3ee6889347fe5065ccb2d16fd19e783c612661a8985f0040e1a5443b5368',
  })

  depends_on 'libgcrypt'
  depends_on 'libwebp'
  depends_on 'libxslt'
  depends_on 'libzip'
  depends_on 'curl'
  depends_on 'exif'
  depends_on 'freetype'
  depends_on 'pcre'
  depends_on 're2c'
  depends_on 'tidy'
  depends_on 'unixodbc'

  def self.preinstall
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "PHP version #{phpver} already installed.".lightred unless "#{phpver}" == ""
  end

  def self.patch
    # Configuration
    system "sed -i 's,;pid = run/php-fpm.pid,pid = #{CREW_PREFIX}/tmp/run/php-fpm.pid,' sapi/fpm/php-fpm.conf.in"
    system "sed -i 's,;error_log = log/php-fpm.log,error_log = #{CREW_PREFIX}/log/php-fpm.log,' sapi/fpm/php-fpm.conf.in"
    system "sed -i 's,include=@php_fpm_sysconfdir@/php-fpm.d,include=#{CREW_PREFIX}/etc/php-fpm.d,' sapi/fpm/php-fpm.conf.in"
    system "sed -i 's,^user,;user,' sapi/fpm/www.conf.in"
    system "sed -i 's,^group,;group,' sapi/fpm/www.conf.in"
    system "sed -i 's,@sbindir@,#{CREW_PREFIX}/bin,' sapi/fpm/init.d.php-fpm.in"
    system "sed -i 's,@sysconfdir@,#{CREW_PREFIX}/etc,' sapi/fpm/init.d.php-fpm.in"
    system "sed -i 's,@localstatedir@,#{CREW_PREFIX}/tmp,' sapi/fpm/init.d.php-fpm.in"
    # Set some sane defaults
    system "sed -i 's,post_max_size = 8M,post_max_size = 128M,' php.ini-development"
    system "sed -i 's,upload_max_filesize = 2M,upload_max_filesize = 128M,' php.ini-development"
    system "sed -i 's,;opcache.enable=0,opcache.enable=1,' php.ini-development"
    # Fix cc: error: ext/standard/.libs/type.o: No such file or directory
    #system "sed -i '98303d' configure"
    #system "sed -i '98295,98296d' configure"
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--docdir=#{CREW_PREFIX}/doc",
           "--infodir=#{CREW_PREFIX}/info",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--localstatedir=#{CREW_PREFIX}/tmp",
           "--mandir=#{CREW_PREFIX}/share/man",
           "--sbindir=#{CREW_PREFIX}/bin",
           "--with-config-file-path=#{CREW_PREFIX}/etc",
           "--with-libdir=#{ARCH_LIB}",
           "--with-freetype-dir=#{CREW_PREFIX}/include/freetype2/freetype",
           "--with-pcre-regex=#{CREW_LIB_PREFIX}",
           "--with-jpeg-dir=#{CREW_LIB_PREFIX}",
           "--with-kerberos=#{CREW_LIB_PREFIX}",
           "--with-png-dir=#{CREW_LIB_PREFIX}",
           "--with-webp-dir=#{CREW_LIB_PREFIX}",
           "--with-xpm-dir=#{CREW_LIB_PREFIX}",
           '--enable-exif',
           '--enable-fpm',
           '--enable-ftp',
           '--enable-mbstring',
           '--enable-opcache',
           '--enable-pcntl',
           '--enable-shared',
           '--enable-shmop',
           '--enable-sockets',
           '--enable-zip',
           '--with-bz2',
           '--with-curl',
           '--with-gd',
           '--with-gettext',
           '--with-gmp',
           '--with-libzip',
           '--with-mysqli',
           '--with-openssl',
           '--with-pcre-regex',
           '--with-pdo-mysql',
           '--with-pear',
           '--with-readline',
           '--with-tidy',
           '--with-unixODBC',
           '--with-xsl',
           '--with-zlib'
    system 'make'
  end

  def self.check
    #system 'make', 'test'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/log"
    system "mkdir -p #{CREW_DEST_PREFIX}/tmp/run"
    system "make", "INSTALL_ROOT=#{CREW_DEST_DIR}", "install"
    system "install -Dm644 php.ini-development #{CREW_DEST_PREFIX}/etc/php.ini"
    system "install -Dm755 sapi/fpm/init.d.php-fpm.in #{CREW_DEST_PREFIX}/etc/init.d/php-fpm"
    system "install -Dm644 sapi/fpm/php-fpm.conf.in #{CREW_DEST_PREFIX}/etc/php-fpm.conf"
    system "install -Dm644 sapi/fpm/www.conf.in #{CREW_DEST_PREFIX}/etc/php-fpm.d/www.conf"
    system "ln -s #{CREW_PREFIX}/etc/init.d/php-fpm #{CREW_DEST_PREFIX}/bin/php7-fpm"

    # clean up some files created under #{CREW_DEST_DIR}. check http://pear.php.net/bugs/bug.php?id=20383 for more details
    system "mv", "#{CREW_DEST_DIR}/.depdb", "#{CREW_DEST_LIB_PREFIX}/php"
    system "mv", "#{CREW_DEST_DIR}/.depdblock", "#{CREW_DEST_LIB_PREFIX}/php"
    system "rm", "-rf", "#{CREW_DEST_DIR}/.channels", "#{CREW_DEST_DIR}/.filemap", "#{CREW_DEST_DIR}/.lock", "#{CREW_DEST_DIR}/.registry"
  end

  def self.postinstall
    puts
    puts "To start the php-fpm service, execute:".lightblue
    puts "php7-fpm start".lightblue
    puts
    puts "To stop the php-fpm service, execute:".lightblue
    puts "php7-fpm stop".lightblue
    puts
    puts "To restart the php-fpm service, execute:".lightblue
    puts "php7-fpm restart".lightblue
    puts
    puts "To start php-fpm on login, execute the following:".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/php7-fpm ]; then' >> ~/.bashrc".lightblue
    puts "echo '  #{CREW_PREFIX}/bin/php7-fpm start' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
  end
end
