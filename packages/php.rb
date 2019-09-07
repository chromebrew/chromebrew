require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.40-7.3.9'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "PHP version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the PHP version to install:"
    puts "5.6 = PHP 5.6.40"
    puts "7.0 = PHP 7.0.33"
    puts "7.1 = PHP 7.1.32"
    puts "7.2 = PHP 7.2.22"
    puts "7.3 = PHP 7.3.9"
    puts "  0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '5.6'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.40-1-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.40-1-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.40-1-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.40-1-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'c70edbf5ed87c65852ebae34aa83273e810b6727e630b7416d2ee68d56722398',
           armv7l: 'c70edbf5ed87c65852ebae34aa83273e810b6727e630b7416d2ee68d56722398',
             i686: '58320b4a5e73dbc5d028bc0969f28fd606e7aa6b2367aa2cf8b61fc043ce8740',
           x86_64: '5e7f5461af3627f086a84bc62a26de7cdc907493244fbecd65be02c6ad9869bb',
        })
        $ver = 5
        break
      when '7.0'
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
        $ver = 7
        break
      when '7.1'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.32-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.32-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.32-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.32-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '815abac490c5c0720400d33cadf87c8f978f15acda6c3c7cec48264c8ae3764b',
           armv7l: '815abac490c5c0720400d33cadf87c8f978f15acda6c3c7cec48264c8ae3764b',
             i686: '52ab264830584668083531e9ed9d348b8a029276539363de79764878b1932c09',
           x86_64: 'd0173dffc3a07fea63967a035991fbd0153a73e74e2752cd2478c35f47c88e23',
        })
        $ver = 7
        break
      when '7.2'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.22-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.22-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.22-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.22-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'cb8bbb7e9666ea74b10ab562695ffa6f1fbd4145960a3fa628cc366e1a12d89d',
           armv7l: 'cb8bbb7e9666ea74b10ab562695ffa6f1fbd4145960a3fa628cc366e1a12d89d',
             i686: 'a50dbc34afa19b386610c75ae4ded25a38351f79b7dc460888be2e1b59925485',
           x86_64: 'c4e7dd6bc074f24ac34d6e7ba0fc49875de5ec4491f483b82c7c839525ecbde1',
        })
        $ver = 7
        break
      when '7.3'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.9-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.9-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.9-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.9-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '5958b598c6edc0c448ebd34baf88e60624443f3cf73e26a660aa6c4f0c255a78',
           armv7l: '5958b598c6edc0c448ebd34baf88e60624443f3cf73e26a660aa6c4f0c255a78',
             i686: '328e967c9134cdb4965ba1a2caff4f4a8bf6ce951c0aad852af9ffcfcbc5a2e9',
           x86_64: '6c00a9890a70347299a9dc25a36494707a461e3ea2eeba3bc3b9cfda47063443',
        })
        $ver = 7
        break
      when '0'
        abort
        break
      else
        puts "Please select from one of the options or enter 0 to cancel."
      end
    end
  end

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

  def self.postinstall
    puts
    puts "To start the php-fpm service, execute:".lightblue
    puts "php#{$ver}-fpm start".lightblue
    puts
    puts "To stop the php-fpm service, execute:".lightblue
    puts "php#{$ver}-fpm stop".lightblue
    puts
    puts "To restart the php-fpm service, execute:".lightblue
    puts "php#{$ver}-fpm restart".lightblue
    puts
    puts "To start php-fpm on login, execute the following:".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/php#{$ver}-fpm ]; then' >> ~/.bashrc".lightblue
    puts "echo '  #{CREW_PREFIX}/bin/php#{$ver}-fpm start' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
  end
end
