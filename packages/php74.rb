require 'package'

class Php74 < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  @_ver = '7.4.22'
  version @_ver
  license 'PHP-3.01'
  compatibility 'all'
  source_url "https://www.php.net/distributions/php-#{@_ver}.tar.xz"
  source_sha256 '8e078cd7d2f49ac3fcff902490a5bb1addc885e7e3b0d8dd068f42c68297bde8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/php74/7.4.22_armv7l/php74-7.4.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/php74/7.4.22_armv7l/php74-7.4.22-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/php74/7.4.22_i686/php74-7.4.22-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/php74/7.4.22_x86_64/php74-7.4.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256({
    aarch64: '5f7ad8b776079e5a436cb4462e190005bfd25d168a7182fe8b96f50c6b129eed',
     armv7l: '5f7ad8b776079e5a436cb4462e190005bfd25d168a7182fe8b96f50c6b129eed',
       i686: 'd7d10b351d9990b490068a248cfebf804d18107e07979aebceef7171e96a565e',
     x86_64: 'bcb56488cfc623c5bd0dde93b116c3d6ab94987914eb9fd57a7568a8dead6232',
  })

  depends_on 'aspell_en'
  depends_on 'libcurl'
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

  def self.preflight
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    unless ARGV[0] == 'reinstall' and version == phpver
      abort "PHP version #{phpver} already installed.".lightgreen unless phpver.empty?
    end
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
    system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} CFLAGS='-pipe' \
      ./configure \
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
       --enable-bcmath \
       --enable-calendar \
       --enable-dba=shared \
       --enable-exif \
       --enable-fpm \
       --enable-ftp \
       --enable-gd \
       --enable-intl \
       --enable-mbstring \
       --enable-mysqlnd \
       --enable-opcache \
       --enable-pcntl \
       --enable-shared \
       --enable-shmop \
       --enable-soap \
       --enable-sockets \
       --enable-sysvmsg \
       --with-bz2 \
       --with-curl \
       --with-ffi \
       --with-freetype \
       --with-gdbm \
       --with-gettext \
       --with-gmp \
       --with-jpeg \
       --with-ldap \
       --with-ldap-sasl \
       --with-libedit \
       --with-mysqli \
       --with-openssl \
       --with-pdo-mysql \
       --with-pspell \
       --with-readline \
       --with-sodium \
       --with-tidy \
       --with-unixODBC \
       --with-xmlrpc \
       --with-xsl \
       --with-zip"
    system 'make'
  end

  def self.check
    # system 'make', 'test'
  end

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/init.d"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/php-fpm.d"
    system 'make', "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
    FileUtils.install 'php.ini-development', "#{CREW_DEST_PREFIX}/etc/php.ini", mode: 0644
    FileUtils.install 'sapi/fpm/init.d.php-fpm.in', "#{CREW_DEST_PREFIX}/etc/init.d/php-fpm", mode: 0755
    FileUtils.install 'sapi/fpm/php-fpm.conf.in', "#{CREW_DEST_PREFIX}/etc/php-fpm.conf", mode: 0755
    FileUtils.install 'sapi/fpm/www.conf.in', "#{CREW_DEST_PREFIX}/etc/php-fpm.d/www.conf", mode:0644
    FileUtils.ln_s "#{CREW_PREFIX}/etc/init.d/php-fpm", "#{CREW_DEST_PREFIX}/bin/php7-fpm"

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
    puts 'php7-fpm start'.lightblue
    puts
    puts 'To stop the php-fpm service, execute:'.lightblue
    puts 'php7-fpm stop'.lightblue
    puts
    puts 'To restart the php-fpm service, execute:'.lightblue
    puts 'php7-fpm restart'.lightblue
    puts
    puts 'To start php-fpm on login, execute the following:'.lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/php7-fpm ]; then' >> ~/.bashrc".lightblue
    puts "echo '  #{CREW_PREFIX}/bin/php7-fpm start' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts 'source ~/.bashrc'.lightblue
  end
end
