require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.35-7.2.4'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "Php version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the php version to install:"
    puts "5.6 = PHP 5.6.35"
    puts "7.0 = PHP 7.0.29"
    puts "7.1 = PHP 7.1.16"
    puts "7.2 = PHP 7.2.4"
    puts "  0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '5.6'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.35-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.35-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.35-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.35-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'd3effb35a61f47e79ae459b36b49ee40bfc2a30626cee8bf73f5614965413cdd',
           armv7l: 'd3effb35a61f47e79ae459b36b49ee40bfc2a30626cee8bf73f5614965413cdd',
             i686: '96430c77f94a022f8b94734af36614368f26d3b2bab8bb4f240c3b908e729e52',
           x86_64: '0772f8d82fd27a2d3bae83d27929950cc80db59d2e0f70d8db04f131f6cad753',
        })
        $ver = 5
        break
      when '7.0'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.29-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.29-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.29-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.29-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'cef6f7257f89af0a97e4f7dae53fdddbd07c4c7c31041009bb3d06496878a3c8',
           armv7l: 'cef6f7257f89af0a97e4f7dae53fdddbd07c4c7c31041009bb3d06496878a3c8',
             i686: 'f0e7a0cba2abe6d0864d90bd2a0236b47f9e2377d77604ffb2affa34663045dc',
           x86_64: 'efbe00b2660a59a37684e46401c7ed1dfecf39d768af17b8c16aef08ec7424fc',
        })
        $ver = 7
        break
      when '7.1'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.16-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.16-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.16-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.16-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '9d3daf1119195a8787a61c25d427077f1e008e785698b8310458a53322300b57',
           armv7l: '9d3daf1119195a8787a61c25d427077f1e008e785698b8310458a53322300b57',
             i686: 'dcfb2bf1ae0b7462b512ccdc70ec5f34529c5811cb01b58f1688fed437eaf559',
           x86_64: '0f0f2ad8abf56ff758e9a1ce0b6fce0c9108716a318e6f8d508931ae7b393658',
        })
        $ver = 7
        break
      when '7.2'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.4-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.4-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.4-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.4-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '3cf53ef772dada3e75f9582d67648b5136668a9a86bda5ed506c555103c597e3',
           armv7l: '3cf53ef772dada3e75f9582d67648b5136668a9a86bda5ed506c555103c597e3',
             i686: '2a9969194dba7b3c03fa13519d136402a2b67f54742af4cae365b70bdbee8300',
           x86_64: '07832256ee0f311534432a5cf074e179a4f1928627af868c63b16b5a4e23dc1d',
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
