require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.40-7.3.10'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "PHP version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the PHP version to install:"
    puts "5.6 = PHP 5.6.40"
    puts "7.0 = PHP 7.0.33"
    puts "7.1 = PHP 7.1.32"
    puts "7.2 = PHP 7.2.23"
    puts "7.3 = PHP 7.3.10"
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
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.23-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.23-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.23-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.23-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '987dfa8a8f21d6f9b808315b1e18f03ab4c30e2291e5c6fe735a9068b2f1911c',
           armv7l: '987dfa8a8f21d6f9b808315b1e18f03ab4c30e2291e5c6fe735a9068b2f1911c',
             i686: '4f4334f46fa89234120da9f436583f72775f88cf3c6047d2eff29002fdfd7feb',
           x86_64: '993b0929dd730fe250c00d473ecbd8a51906421decac5561af6f5f94e46b4d53',
        })
        $ver = 7
        break
      when '7.3'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.10-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.10-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.10-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.10-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '2d42966f10bf6b62b8501a25653be30b2ed7a1cc13fe6c5ccb5885bf5a9d2972',
           armv7l: '2d42966f10bf6b62b8501a25653be30b2ed7a1cc13fe6c5ccb5885bf5a9d2972',
             i686: '2e38a2a59e784978e45875bfa5ebb4a0bddafb017a2f4999abf872820e1112f5',
           x86_64: '40632972ee96b64933e317129c44c47f9ed65dcd4a55b4f34118a1f5ea80fa63',
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
