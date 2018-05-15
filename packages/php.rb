require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.36-7.2.5'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "Php version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the php version to install:"
    puts "5.6 = PHP 5.6.36"
    puts "7.0 = PHP 7.0.30"
    puts "7.1 = PHP 7.1.17"
    puts "7.2 = PHP 7.2.5"
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
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.17-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.17-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.17-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.17-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '5a4d564f297f2658ee73f1d88da8fa3e244343ae74859414850f28a6197954c2',
           armv7l: '5a4d564f297f2658ee73f1d88da8fa3e244343ae74859414850f28a6197954c2',
             i686: 'e8a4fe2482b56e56014573ab1c32eef1dde76c58807220095245603e50485e6c',
           x86_64: '558b96776d8499be44da5686e75d69857e2ccee0199c67ca6dc5afb39208086e',
        })
        $ver = 7
        break
      when '7.2'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.5-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.5-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.5-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.5-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '5a797e8599c4cc221c8589123abc2db8fb9c1a75aa4ac62ecf046dca13d0032e',
           armv7l: '5a797e8599c4cc221c8589123abc2db8fb9c1a75aa4ac62ecf046dca13d0032e',
             i686: '79853aac86398b3508e805971fd8b6c15c5b34076418bb1cff165c5e1932b0ab',
           x86_64: '6efecf45304e9967e1edc3090d08679a5cde7a3747ee1ca518cfa59afd3f94f6',
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
