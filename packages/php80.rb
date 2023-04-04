require 'package'

class Php80 < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '8.0.28'
  license 'PHP-3.01'
  compatibility 'all'
  source_url 'https://www.php.net/distributions/php-8.0.28.tar.xz'
  source_sha256 '5e07278a1f315a67d36a676c01343ca2d4da5ec5bdb15d018e4248b3012bc0cd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/php80/8.0.28_armv7l/php80-8.0.28-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/php80/8.0.28_armv7l/php80-8.0.28-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/php80/8.0.28_i686/php80-8.0.28-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/php80/8.0.28_x86_64/php80-8.0.28-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '742b7cdfc06c40a84e6d92e39a81e5d4b072f3b083ed86873459a5f95adb8492',
     armv7l: '742b7cdfc06c40a84e6d92e39a81e5d4b072f3b083ed86873459a5f95adb8492',
       i686: '544f70d48329958ecf2706e7d2c41a74433ea6f185862b2904bd6899df4ebd85',
     x86_64: '8e3974cf4c7359a28d22143f926e7b050014a4f6ce0d2374f29cb3f593101a6f'
  })

  depends_on 'aspell_en'
  depends_on 'curl'
  depends_on 'libgcrypt'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libsodium'
  depends_on 'libxpm'
  depends_on 'libxslt'
  depends_on 'libzip'
  depends_on 'exif'
  depends_on 'freetds'
  depends_on 'freetype'
  depends_on 'graphite'
  depends_on 're2c'
  depends_on 'tidy'
  depends_on 'unixodbc'
  depends_on 'oniguruma'
  depends_on 'py3_pygments'

  no_fhs

  def self.preflight
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "PHP version #{phpver} already installed.".lightgreen if ARGV[0] != 'reinstall' && @_ver != phpver && !phpver.empty?
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
    # system "sed -i '98303d' configure"
    # system "sed -i '98295,98296d' configure"
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "CFLAGS='-pipe' mold -run ./configure \
       --prefix=#{CREW_PREFIX} \
       --docdir=#{CREW_PREFIX}/doc \
       --infodir=#{CREW_PREFIX}/info \
       --libdir=#{CREW_LIB_PREFIX} \
       --localstatedir=#{CREW_PREFIX}/var \
       --mandir=#{CREW_MAN_PREFIX} \
       --sbindir=#{CREW_PREFIX}/bin \
       --with-config-file-path=#{CREW_PREFIX}/etc \
       --with-libdir=#{ARCH_LIB} \
       --with-kerberos=#{CREW_LIB_PREFIX} \
       --with-pear=#{CREW_LIB_PREFIX}/php \
       --with-zlib-dir=#{CREW_LIB_PREFIX} \
       --enable-exif \
       --enable-fpm \
       --enable-ftp \
       --enable-gd \
       --enable-mbstring \
       --enable-opcache \
       --enable-pcntl \
       --enable-shared \
       --enable-shmop \
       --enable-sockets \
       --enable-bcmath \
       --enable-calendar \
       --enable-dba=shared \
       --enable-intl \
       --enable-mysqlnd \
       --enable-opcache \
       --enable-soap \
       --enable-sysvmsg \
       --with-zip \
       --with-bz2 \
       --with-curl \
       --with-gettext \
       --with-gmp \
       --with-mysqli \
       --with-openssl \
       --with-pdo-mysql \
       --with-readline \
       --with-tidy \
       --with-unixODBC \
       --with-xsl \
       --with-zlib \
       --with-freetype \
       --with-gdbm \
       --with-jpeg \
       --with-ldap \
       --with-ldap-sasl \
       --with-pspell \
       --with-sodium \
       --with-zip \
       --with-ffi \
       --with-libedit"
    system 'mold -run make'
  end

  def self.check
    # system 'make', 'test'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/tmp/run"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/init.d"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/php-fpm.d"
    system 'make', "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
    FileUtils.install 'php.ini-development', "#{CREW_DEST_PREFIX}/etc/php.ini", mode: 0o644
    FileUtils.install 'sapi/fpm/init.d.php-fpm.in', "#{CREW_DEST_PREFIX}/etc/init.d/php-fpm", mode: 0o755
    FileUtils.install 'sapi/fpm/php-fpm.conf.in', "#{CREW_DEST_PREFIX}/etc/php-fpm.conf", mode: 0o755
    FileUtils.install 'sapi/fpm/www.conf.in', "#{CREW_DEST_PREFIX}/etc/php-fpm.d/www.conf", mode: 0o644
    FileUtils.ln_s "#{CREW_PREFIX}/etc/init.d/php-fpm", "#{CREW_DEST_PREFIX}/bin/php8-fpm"

    # clean up some files created under #{CREW_DEST_DIR}. check http://pear.php.net/bugs/bug.php?id=20383 for more details
    FileUtils.mv "#{CREW_DEST_PREFIX}/php/php/fpm", "#{CREW_DEST_LIB_PREFIX}/php"
    FileUtils.mv "#{CREW_DEST_DIR}/.depdb", "#{CREW_DEST_LIB_PREFIX}/php"
    FileUtils.mv "#{CREW_DEST_DIR}/.depdblock", "#{CREW_DEST_LIB_PREFIX}/php"
    FileUtils.rm_rf "#{CREW_DEST_DIR}/.channels"
    FileUtils.rm_rf "#{CREW_DEST_DIR}/.filemap"
    FileUtils.rm_rf "#{CREW_DEST_DIR}/.lock"
    FileUtils.rm_rf "#{CREW_DEST_DIR}/.registry"
  end

  def self.postinstall
    puts
    puts 'To start the php-fpm service, execute:'.lightblue
    puts 'php8-fpm start'.lightblue
    puts
    puts 'To stop the php-fpm service, execute:'.lightblue
    puts 'php8-fpm stop'.lightblue
    puts
    puts 'To restart the php-fpm service, execute:'.lightblue
    puts 'php8-fpm restart'.lightblue
    puts
    puts 'To start php-fpm on login, execute the following:'.lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/php8-fpm ]; then' >> ~/.bashrc".lightblue
    puts "echo '  #{CREW_PREFIX}/bin/php8-fpm start' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts 'source ~/.bashrc'.lightblue
  end
end
