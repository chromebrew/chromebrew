require 'package'

class Php82 < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '8.2.14'
  license 'PHP-3.01'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.php.net/distributions/php-8.2.14.tar.xz'
  source_sha256 '763ecd39fcf51c3815af6ef6e43fa9aa0d0bd8e5a615009e5f4780c92705f583'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/php82/8.2.14_armv7l/php82-8.2.14-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/php82/8.2.14_armv7l/php82-8.2.14-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/php82/8.2.14_x86_64/php82-8.2.14-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5238263a9f7579dda27a22dd688ff45d96d5076168910eb3ff8d83936efe7e99',
     armv7l: '5238263a9f7579dda27a22dd688ff45d96d5076168910eb3ff8d83936efe7e99',
     x86_64: '03db149e61d36af1d44b1fe8fc83799145784289e043f08c0de7bb58e22bbe68'
  })

  depends_on 'aspell_en' => :build
  depends_on 'aspell' # R
  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'c_ares' # R
  depends_on 'curl' # R
  depends_on 'e2fsprogs' # R
  depends_on 'exif'
  depends_on 'freetds'
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'graphite'
  depends_on 'icu4c' # R
  depends_on 'krb5' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libedit' # R
  depends_on 'libffi' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgd' # R
  depends_on 'libgpgerror' # R
  depends_on 'libidn2' # R
  depends_on 'libjpeg' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpng' # R
  depends_on 'libpsl' # R
  depends_on 'libsodium' # R
  depends_on 'libssh' # R
  depends_on 'libtool' # R
  depends_on 'libunistring' # R
  depends_on 'libxml2' # R
  depends_on 'libxpm'
  depends_on 'libxslt' # R
  depends_on 'libzip' # R
  depends_on 'ncurses' # R
  depends_on 'oniguruma' # R
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'py3_pygments'
  depends_on 're2c'
  depends_on 'sqlite' # R
  depends_on 'tidy' # R
  depends_on 'unixodbc' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  no_fhs

  def self.preflight
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    return unless ARGV[0] != 'reinstall' && version != phpver && !phpver.empty?

    abort "PHP version #{phpver} already installed.".lightgreen
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
    system "mold -run ./configure \
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
       --disable-gcc-global-regs \
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
    system 'make'
  end

  def self.check
    # system 'make', 'test'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/tmp/run"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"

    system 'make', "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
    FileUtils.install 'php.ini-development', "#{CREW_DEST_PREFIX}/etc/php.ini", mode: 0o644
    FileUtils.install 'sapi/fpm/init.d.php-fpm.in', "#{CREW_DEST_PREFIX}/etc/init.d/php-fpm", mode: 0o755
    FileUtils.install 'sapi/fpm/php-fpm.conf.in', "#{CREW_DEST_PREFIX}/etc/php-fpm.conf", mode: 0o644
    FileUtils.install 'sapi/fpm/www.conf.in', "#{CREW_DEST_PREFIX}/etc/php-fpm.d/www.conf", mode: 0o644
    FileUtils.ln_s "#{CREW_PREFIX}/etc/init.d/php-fpm", "#{CREW_DEST_PREFIX}/bin/php8-fpm"

    # Clean up some files created under #{CREW_DEST_DIR}.
    # Check http://pear.php.net/bugs/bug.php?id=20383 for more details.
    FileUtils.mv "#{CREW_DEST_PREFIX}/php/php/fpm", "#{CREW_DEST_LIB_PREFIX}/php"
    FileUtils.mv "#{CREW_DEST_DIR}/.depdb", "#{CREW_DEST_LIB_PREFIX}/php"
    FileUtils.mv "#{CREW_DEST_DIR}/.depdblock", "#{CREW_DEST_LIB_PREFIX}/php"
    FileUtils.rm_rf "#{CREW_DEST_DIR}/.channels"
    FileUtils.rm_rf "#{CREW_DEST_DIR}/.filemap"
    FileUtils.rm_rf "#{CREW_DEST_DIR}/.lock"
    FileUtils.rm_rf "#{CREW_DEST_DIR}/.registry"

    # Launch php8-fpm when the bash shell session starts.
    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/01-php8-fpm", <<~EOF
      [ -x #{CREW_PREFIX}/bin/php8-fpm ] && #{CREW_PREFIX}/bin/php8-fpm start
    EOF
  end

  def self.postinstall
    ExitMessage.add <<~EOF.lightblue

      To start the php-fpm service, execute:
      php8-fpm start

      To stop the php-fpm service, execute:
      php8-fpm stop

      To restart the php-fpm service, execute:
      php8-fpm restart

      php8-fpm start will execute on login.
      To prevent this, edit or remove #{CREW_PREFIX}/etc/bash.d/01-php8-fpm.

    EOF
  end
end
