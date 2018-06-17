require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.36-7.2.6'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "Php version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the php version to install:"
    puts "5.6 = PHP 5.6.36"
    puts "7.0 = PHP 7.0.30"
    puts "7.1 = PHP 7.1.18"
    puts "7.2 = PHP 7.2.6"
    puts "  0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '5.6'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.36-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.36-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.36-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.36-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'f1704e75ec47496d6cdb221a99c51e666cd84973ff92f170be75cd1a3f10c951',
           armv7l: 'f1704e75ec47496d6cdb221a99c51e666cd84973ff92f170be75cd1a3f10c951',
             i686: 'd6240fef149bd90b2dfdf2b4b4559f46f344a326ef1b6a405a973445ee83f7fc',
           x86_64: '2c96f21d5826543789a26ac033ab7a02e615003c4f58b70ba7a8a06496c9745d',
        })
        $ver = 5
        break
      when '7.0'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.30-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.30-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.30-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.30-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '6135e9cf806df5f31518fe4d9f287e8c1330f9506bd6d31ef1def792291abecc',
           armv7l: '6135e9cf806df5f31518fe4d9f287e8c1330f9506bd6d31ef1def792291abecc',
             i686: '75ae742d9863e19896bc62581866eb7c61c2530f6972ecfed74ba79b70865f03',
           x86_64: 'd3c45e10694972f3282c5259b7bb9f05b64210d023e04703115c99c501c1220f',
        })
        $ver = 7
        break
      when '7.1'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.18-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.18-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.18-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.18-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'af8ad9a7274e954e9a6cee2047462e68f86e003021d619fe6a626a9aaaac2470',
           armv7l: 'af8ad9a7274e954e9a6cee2047462e68f86e003021d619fe6a626a9aaaac2470',
             i686: 'cfc746000f3c26e7ebaf8afad096b98b0647e490e1865398d27cc420605738b2',
           x86_64: '97b79ad90d6c2bc8359a1a64f0051c1f8988c372390ca4974ef1a97b872f14c7',
        })
        $ver = 7
        break
      when '7.2'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.6-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.6-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.6-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.6-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '3053099db705b825c0f1f35913b9c69bad20d35f6ddd7581c0eb20e4433ec342',
           armv7l: '3053099db705b825c0f1f35913b9c69bad20d35f6ddd7581c0eb20e4433ec342',
             i686: '06e6fce8d54e425edc864eb7912521ffb2a2c5cfcf88ad83ddaf7f4c1d3853f4',
           x86_64: '9f05e236dedcf92e85ef69ac6cd70a470a4e78dc4a7812d15eedfbad25ad5060',
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

  depends_on 'icu4c'
  depends_on 'libgcrypt'
  depends_on 'libpng'
  depends_on 'libxslt'
  depends_on 'curl'
  depends_on 'pcre'
  depends_on 'readline'

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
