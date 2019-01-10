require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.39-7.3.0'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "Php version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the php version to install:"
    puts "5.6 = PHP 5.6.39"
    puts "7.0 = PHP 7.0.33"
    puts "7.1 = PHP 7.1.25"
    puts "7.2 = PHP 7.2.13"
    puts "7.3 = PHP 7.3.0"
    puts "  0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '5.6'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.39-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.39-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.39-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.39-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '5a0be4837ee67281c647a74b98e9d893dda07266bfc542ef1b87b5143791fb19',
           armv7l: '5a0be4837ee67281c647a74b98e9d893dda07266bfc542ef1b87b5143791fb19',
             i686: '383ac377bd617182bbca5a41ddac52105bbccd3754268ca0c4d04556848965a7',
           x86_64: 'fe93b5fd684e10bac3b6e74c8a4150c9231e6febfe80061917130a94b6f1e094',
        })
        $ver = 5
        break
      when '7.0'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.33-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.33-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.33-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.33-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '0f265657ebc48ef210a5058e619a5819b34cde3c87ed1d8bd16795425acee36d',
           armv7l: '0f265657ebc48ef210a5058e619a5819b34cde3c87ed1d8bd16795425acee36d',
             i686: 'b61e1dc6dd810e57d0737a555000933efbc04e421643a775361cbf191afa1188',
           x86_64: 'b58ecb0ba8ba6b8310a7c9060e5ff5f64c3fdc11e23285fab4cebbda6704e5c9',
        })
        $ver = 7
        break
      when '7.1'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.25-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.25-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.25-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.25-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '41ff2144c2e1d6d87412736eedfbd267362a817e164eb226aac2a5332bff8871',
           armv7l: '41ff2144c2e1d6d87412736eedfbd267362a817e164eb226aac2a5332bff8871',
             i686: 'd3a2555f4127ba4837a819070314a2987b21c3053b10565a09c05c19ce296715',
           x86_64: '3d73d6e75bcef3a42dfa7bbaf458021753b1fb1c0b6329dbd1cab6e1f4f0bdc6',
        })
        $ver = 7
        break
      when '7.2'
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
        $ver = 7
        break
      when '7.3'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.0-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.0-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.0-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.0-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '96537d016c335816a0540c6e96bee856bc7d81fc7ed5fcdb5bd9abffb5b3f3b6',
           armv7l: '96537d016c335816a0540c6e96bee856bc7d81fc7ed5fcdb5bd9abffb5b3f3b6',
             i686: '2ab4ff20cd0feac5515788cc59477b61d35d7cab4f499f02df41eaed3f15fb91',
           x86_64: 'c58287f53287258d2ce073f69a318cceed8cae541cdb3ff0a31998153df3c439',
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

  depends_on 'readline7'
  depends_on 'libgcrypt'
  depends_on 'libpng'
  depends_on 'libxslt'
  depends_on 'curl'
  depends_on 'pcre'

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
