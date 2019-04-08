require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.40-7.3.4'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "PHP version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the PHP version to install:"
    puts "5.6 = PHP 5.6.40"
    puts "7.0 = PHP 7.0.33"
    puts "7.1 = PHP 7.1.28"
    puts "7.2 = PHP 7.2.17"
    puts "7.3 = PHP 7.3.4"
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
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.28-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.28-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.28-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.28-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '9ea62e3401003510c4ac490859d1f68a8e5464eed9eb80b2ef46d58931b88808',
           armv7l: '9ea62e3401003510c4ac490859d1f68a8e5464eed9eb80b2ef46d58931b88808',
             i686: 'e1039b896be6b3abbaebac5a21bb99b07cc7525305362a1fb0727d736cf321be',
           x86_64: '27bf2057cb6b9d060f50f76c06f50c09c08c7f9d754f95d5e2b2d64bcd513750',
        })
        $ver = 7
        break
      when '7.2'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.17-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.17-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.17-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.17-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'aba9f4b68ac33a105bb135d71a40bc7f777aa27d6f8199ed3f8fa52dd2e7caf8',
           armv7l: 'aba9f4b68ac33a105bb135d71a40bc7f777aa27d6f8199ed3f8fa52dd2e7caf8',
             i686: '1a43bd9bade0d298840eb2cc4f6f84ad060b5ba36da3dba50d9170fcee803cec',
           x86_64: '828c4a9f5960e7fd9bce9b7dccc4256520120deb36ac9aa8c6ffb4a947836ee1',
        })
        $ver = 7
        break
      when '7.3'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.4-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.4-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.4-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.4-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'c947e49208bf12a9ff30fc271d049c3207bee9f66b79f4b1baaf11c82b88255c',
           armv7l: 'c947e49208bf12a9ff30fc271d049c3207bee9f66b79f4b1baaf11c82b88255c',
             i686: '9549a8c69b3c3a31a47d29c188d41fbe3566682f8780bf357c4be3123a674b03',
           x86_64: '483cc2241d4aec2d4d236dc5383096db99c4d2c53b65399503edf455499de2ca',
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
