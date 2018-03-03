require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.34-7.2.3'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "Php version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the php version to install:"
    puts "5.6 = PHP 5.6.34"
    puts "7.0 = PHP 7.0.28"
    puts "7.1 = PHP 7.1.15"
    puts "7.2 = PHP 7.2.3"
    puts "  0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '5.6'
        source_url 'https://php.net/distributions/php-5.6.34.tar.xz'
        source_sha256 '21453be3a045204cd2717543ef42771324f411f40962ecda4fe841930a933128'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.34-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.34-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.34-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.34-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'a1eecf07f549303f9c7f397e1a0f947b743e96c0d61da29bc8beb24b0d44b64f',
           armv7l: 'a1eecf07f549303f9c7f397e1a0f947b743e96c0d61da29bc8beb24b0d44b64f',
             i686: 'bbea0f8f7edcde6fb72e97ed8f1088c7445ff2262e2c41e92fce66b7e7b0f42c',
           x86_64: 'fcb5e4863e7a2a5fe4689027f843ffd458e2151ae9bf4a6ee9333b66bc4df96f',
        })
        break
      when '7.0'
        source_url 'https://php.net/distributions/php-7.0.28.tar.xz'
        source_sha256 'e738ffce2c30bc0e84be9446af86bef0a0607d321f1a3d04bbfe2402fb5f6de0'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.28-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.28-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.28-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.28-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '4fa2d6fa475885ad617595fb2c7ca0cdecd5b6fd21d1ed20cf1d2148a962e569',
           armv7l: '4fa2d6fa475885ad617595fb2c7ca0cdecd5b6fd21d1ed20cf1d2148a962e569',
             i686: 'cd87ea91b289f9abd9a0e90dea1583be16bb48e1fdbbd2808de9b2166c70b30e',
           x86_64: '080ed99678f869cd65f712e0a970f77c920dd3ee9c2af9e7fc5ad5bbce3d273f',
        })
        break
      when '7.1'
        source_url 'https://php.net/distributions/php-7.1.15.tar.xz'
        source_sha256 '0e17192fb43532e4ebaa190ecec9c7e59deea7dadb7dab67b19c2081a68bd817'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.15-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.15-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.15-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.15-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'cb84ec920f0d9258852f4f4e7e7c7717b9eeed9199f2368c097aac390261c24d',
           armv7l: 'cb84ec920f0d9258852f4f4e7e7c7717b9eeed9199f2368c097aac390261c24d',
             i686: '1a48ea2f2fcb0dbbc94e537302b61ae6ec973a3ac21b56461f6be3cd8f626325',
           x86_64: 'dc54175f4258696b994881d6fc4d1ef89a77099a1722316661517567e5405108',
        })
        break
      when '7.2'
        source_url 'https://php.net/distributions/php-7.2.3.tar.xz'
        source_sha256 'b3a94f1b562f413c0b96f54bc309706d83b29ac65d9b172bc7ed9fb40a5e651f'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.3-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.3-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.3-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.3-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '076113ce15e8e5f0e2176924d296a9b936fa6e269e2b6d9e9ca2b2b3493f5267',
           armv7l: '076113ce15e8e5f0e2176924d296a9b936fa6e269e2b6d9e9ca2b2b3493f5267',
             i686: 'c8ee47aee521aa13748e0d0a701fd67c8a4aae98a3a8b05aa4fdf01e3b0eb9c4',
           x86_64: 'd38bc3cd1ddbc24c9803aac7d30dfdf1620e67f83b3feeb142ec4bdb35deb825',
        })
        break
      when '0'
        abort
        break
      else
        puts "Please select from one of the options or enter 0 to cancel."
      end
    end
  end

  depends_on 'pkgconfig' => :build
  depends_on 'zlibpkg'
  depends_on 'libgcrypt'
  depends_on 'libpng'
  depends_on 'libxml2'
  depends_on 'libxslt'
  depends_on 'openssl'
  depends_on 'curl'
  depends_on 'pcre'
  depends_on 'readline'

  def self.build
    system "./configure \
      --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX} \
      --with-curl \
      --with-gd \
      --with-xsl \
      --enable-mbstring \
      --with-openssl \
      --with-pcre-regex \
      --with-readline \
      --with-zlib"
    system 'make'
  end

  def self.install
    system "make", "INSTALL_ROOT=#{CREW_DEST_DIR}", "install"

    # clean up some files created under #{CREW_DEST_DIR}. check http://pear.php.net/bugs/bug.php?id=20383 for more details
    system "mv", "#{CREW_DEST_DIR}/.depdb", "#{CREW_DEST_LIB_PREFIX}/php"
    system "mv", "#{CREW_DEST_DIR}/.depdblock", "#{CREW_DEST_LIB_PREFIX}/php"
    system "rm", "-rf", "#{CREW_DEST_DIR}/.channels", "#{CREW_DEST_DIR}/.filemap", "#{CREW_DEST_DIR}/.lock", "#{CREW_DEST_DIR}/.registry"
  end
end
