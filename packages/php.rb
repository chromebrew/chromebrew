require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.33-7.2.2'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "Php version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the php version to install:"
    puts "5.6 = PHP 5.6.33"
    puts "7.0 = PHP 7.0.27"
    puts "7.1 = PHP 7.1.14"
    puts "7.2 = PHP 7.2.2"
    puts "  0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '5.6'
        source_url 'https://php.net/distributions/php-5.6.33.tar.xz'
        source_sha256 '9004995fdf55f111cd9020e8b8aff975df3d8d4191776c601a46988c375f3553'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.33-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.33-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.33-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.33-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'a1eecf07f549303f9c7f397e1a0f947b743e96c0d61da29bc8beb24b0d44b64f',
           armv7l: 'a1eecf07f549303f9c7f397e1a0f947b743e96c0d61da29bc8beb24b0d44b64f',
             i686: 'bbea0f8f7edcde6fb72e97ed8f1088c7445ff2262e2c41e92fce66b7e7b0f42c',
           x86_64: 'fcb5e4863e7a2a5fe4689027f843ffd458e2151ae9bf4a6ee9333b66bc4df96f',
        })
        break
      when '7.0'
        source_url 'https://php.net/distributions/php-7.0.27.tar.xz'
        source_sha256 '4b2bc823e806dbf7b62fe0b92b0d14b0c6e03f88c3fc5d96278416c54ce11f6c'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.27-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.27-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.27-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.27-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '1e2a89fa1eb54959ac16d37c69484321508ece99610a1abe6c636b255f0b4533',
           armv7l: '1e2a89fa1eb54959ac16d37c69484321508ece99610a1abe6c636b255f0b4533',
             i686: '6c4d95bf1745672f370004a5120d308ba7402cece83a457d6eabd3cda779dea3',
           x86_64: 'c57b5e0caba5a158ab04f938a38cf3efb418658d06eb24e7e39a7c013e75d8f7',
        })
        break
      when '7.1'
        source_url 'https://php.net/distributions/php-7.1.14.tar.xz'
        source_sha256 'c09f0c1074f5689b492d79034adb84e6a6c6d08c6763c02282e6318d41156779'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.14-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.14-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.14-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.14-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'f5991cc9a360e18ab56dce4ba78c6d632f9f17fd67e4d4da1360c6efa192da22',
           armv7l: 'f5991cc9a360e18ab56dce4ba78c6d632f9f17fd67e4d4da1360c6efa192da22',
             i686: '7da8b3357b0ad8396089cf1b735ae78dc2f998f6fa5584524a424466395bcda3',
           x86_64: 'cad04f99192b6e65fc9280a061c866d5e652b1215ff201c1f9a6d71aead97bc0',
        })
        break
      when '7.2'
        source_url 'https://php.net/distributions/php-7.2.2.tar.xz'
        source_sha256 ''
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.2-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.2-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.2-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.2-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '905145fcb31e3cabd5f0e7ebccc7733ccb681d5ee0ffc6a374a6ec807cec526c',
           armv7l: '905145fcb31e3cabd5f0e7ebccc7733ccb681d5ee0ffc6a374a6ec807cec526c',
             i686: 'e26a38c963c35436a959d1b9ce414f5545e8a37fe873083888c6b478ae291afb',
           x86_64: 'ae983b4120e31caeff429670004c7dd27ec1db21e5767a2d8b96fdabfd91f587',
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
