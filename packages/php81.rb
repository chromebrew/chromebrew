require 'package'

class Php81 < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'https://www.php.net/'
  version '8.1.34'
  license 'PHP-3.01'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.php.net/distributions/php-#{version}.tar.xz"
  source_sha256 'ffa9e0982e82eeaea848f57687b425ed173aa278fe563001310ae2638db5c251'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f3c9f26d6d94ca751068de453ef3cfcf30fe95d0d93ec250731e879a6df1023',
     armv7l: '4f3c9f26d6d94ca751068de453ef3cfcf30fe95d0d93ec250731e879a6df1023',
     x86_64: 'e3d5a759e23ddd65d80c2e5a6c896b2b57cdfc09265ba3c275021aae87e7223a'
  })

  depends_on 'aspell' => :executable
  depends_on 'aspell_en' => :build
  depends_on 'brotli' => :executable
  depends_on 'bzip2' => :executable
  depends_on 'c_ares' => :executable
  depends_on 'curl' => :executable
  depends_on 'e2fsprogs' => :executable
  depends_on 'exif'
  depends_on 'freetds'
  depends_on 'freetype' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'gdbm' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :executable
  depends_on 'graphite'
  depends_on 'icu4c' => :executable
  depends_on 'jq' # R
  depends_on 'krb5' => :executable
  depends_on 'libcyrussasl' => :executable
  depends_on 'libedit' => :executable
  depends_on 'libffi' => :executable
  depends_on 'libidn2' => :executable
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libnghttp2' => :executable
  depends_on 'libnghttp3' => :executable
  depends_on 'libngtcp2' => :executable
  depends_on 'libpng' => :executable
  depends_on 'libpsl' => :executable
  depends_on 'libsodium' => :executable
  depends_on 'libssh' => :executable
  depends_on 'libtool' => :executable
  depends_on 'libunistring' => :executable
  depends_on 'libxcrypt' => :executable
  depends_on 'libxml2' => :executable
  depends_on 'libxpm'
  depends_on 'libxslt' => :executable
  depends_on 'libzip' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'oniguruma' => :executable
  depends_on 'openldap' => :executable
  depends_on 'openssl' => :executable
  depends_on 'openssl111' => :executable
  depends_on 'py3_pygments'
  depends_on 're2c'
  depends_on 'sqlite' => :executable
  depends_on 'tidy' => :executable
  depends_on 'unixodbc' => :executable
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

  no_fhs

  def self.preflight
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "PHP version #{phpver} already installed.".lightgreen if ARGV[0] != 'reinstall' && version != phpver && !phpver.empty?
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
    system "CFLAGS='-pipe' ./configure \
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
    system 'make'
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

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
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
