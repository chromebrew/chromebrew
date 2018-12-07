require 'package'

class Php7 < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '7.2.13'
  source_url 'https://php.net/distributions/php-7.2.13.tar.xz'
  source_sha256 '14b0429abdb46b65c843e5882c9a8c46b31dfbf279c747293b8ab950c2644a4b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1eba303d85b10189ca84d7004dba52dfbf77599e972d41350c9d5b0d109c0868',
     armv7l: '1eba303d85b10189ca84d7004dba52dfbf77599e972d41350c9d5b0d109c0868',
       i686: 'dca4240c6530c0b05956259bf352fdfbf4de96993a1e87bea518b98e3338e54e',
     x86_64: '816e2a00a31b200b668cfe4da1a4ad5a015e478d4f2af6b5c41a47875c6f6e25',
  })

  depends_on 'readline7'
  depends_on 'libgcrypt'
  depends_on 'libpng'
  depends_on 'libxslt'
  depends_on 'curl'
  depends_on 'pcre'

  def self.patch
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
  end

  def self.build
    system "./configure \
      --prefix=#{CREW_PREFIX} \
      --docdir=#{CREW_PREFIX}/doc \
      --infodir=#{CREW_PREFIX}/info \
      --libdir=#{CREW_LIB_PREFIX} \
      --localstatedir=#{CREW_PREFIX}/tmp \
      --mandir=#{CREW_PREFIX}/man \
      --sbindir=#{CREW_PREFIX}/bin \
      --with-config-file-path=#{CREW_PREFIX}/etc \
      --with-libdir=#{ARCH_LIB} \
      --enable-fpm \
      --enable-mbstring \
      --enable-opcache \
      --with-curl \
      --with-gd \
      --with-xsl \
      --with-mysqli \
      --with-openssl \
      --with-pdo-mysql \
      --with-pcre-regex \
      --with-readline \
      --with-zlib"
    system 'make'
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
