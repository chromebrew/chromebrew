require 'package'

class Php80 < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'https://www.php.net/'
  version '8.0.0'
  compatibility 'all'
  source_url 'https://www.php.net/distributions/php-8.0.0.tar.xz'
  source_sha256 'b5278b3eef584f0c075d15666da4e952fa3859ee509d6b0cc2ed13df13f65ebb'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'argon2'
  depends_on 'aspell_en'
  depends_on 'graphite'
  depends_on 'libedit'
  depends_on 'libgcrypt'
  depends_on 'libjpeg_turbo'
  depends_on 'libsodium'
  depends_on 'libxslt'
  depends_on 'libzip'
  depends_on 'curl'
  depends_on 'exif'
  depends_on 'freetds'
  depends_on 'freetype'
  depends_on 'pcre'
  depends_on 're2c'
  depends_on 'tidy'
  depends_on 'unixodbc'
  depends_on 'oniguruma'

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

    # Libressl claims compat w/ openssl 1.1 but doesn't support OCB; this should be a temp requirement
    patch_url = 'https://bugs.php.net/patch-display.php?bug_id=80368&patch=check_SSL_OCB_support&revision=1606827655&download=1'
    patch_sha256 = 'c62b7cceaab4ea202d071554e742ef185d01c333f46ee2c7f4c4711391a55a35'
    system('wget', '--continue', '--no-check-certificate', patch_url, '-O', 'check_SSL_OCB_support.patch')
    abort 'Checksum mismatch :/ try again' unless Digest::SHA256.hexdigest( File.read("./check_SSL_OCB_support.patch") ) == patch_sha256
    system('patch -p 1 < check_SSL_OCB_support.patch')
  end

  def self.build
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
    ENV['CFLAGS'] = ' -liconv'
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
           "--with-kerberos=#{CREW_LIB_PREFIX}",
           '--enable-bcmath',
           '--enable-calendar',
           '--enable-dba=shared',
           '--enable-exif',
           '--enable-fpm',
           '--enable-ftp',
           '--enable-gd',
           '--enable-intl',
           '--enable-mbstring',
           '--enable-mysqlnd',
           '--enable-opcache',
           '--enable-pcntl',
           '--enable-shared',
           '--enable-shmop',
           '--enable-soap',
           '--enable-sockets',
           '--enable-sysvmsg',
           '--with-bz2',
           '--with-curl',
           '--with-ffi',
           '--with-freetype',
           '--with-gdbm',
           '--with-gettext',
           '--with-gmp',
           '--with-jpeg',
           '--with-kerberos',
           '--with-ldap',
           '--with-ldap-sasl',
           '--with-libedit',
           '--with-mysqli',
           '--with-openssl',
           '--with-pdo-dblib',
           '--with-pdo-mysql',
           '--with-pear',
           '--with-pspell',
           '--with-readline',
           '--with-sodium',
           '--with-tidy',
           '--with-unixODBC',
           '--with-xmlrpc',
           '--with-xsl',
           '--with-zip',
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
