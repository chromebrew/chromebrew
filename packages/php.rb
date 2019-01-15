require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.40-7.3.1'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "PHP version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the PHP version to install:"
    puts "5.6 = PHP 5.6.40"
    puts "7.0 = PHP 7.0.33"
    puts "7.1 = PHP 7.1.26"
    puts "7.2 = PHP 7.2.14"
    puts "7.3 = PHP 7.3.1"
    puts "  0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '5.6'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.40-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.40-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.40-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.40-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '2c856f39c5bea81c5ffd1b0fc57a5046c9987cf44304e1b4b7a9b3f5c8249f6f',
           armv7l: '2c856f39c5bea81c5ffd1b0fc57a5046c9987cf44304e1b4b7a9b3f5c8249f6f',
             i686: '0fe21893525eeb70f2d7f075738e57f9d8edb5ead85e8c5b09de188b244c6a34',
           x86_64: '26b5cc993b96db0bb251db8b5ed54d1b2f25c6c8f81b91e50bef35b4fc62d9ad',
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
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.26-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.26-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.26-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.26-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '4f3026fe98f4ab68ec2e0029abc52c00d8bd61632ec700aa03242c1cf7ac5252',
           armv7l: '4f3026fe98f4ab68ec2e0029abc52c00d8bd61632ec700aa03242c1cf7ac5252',
             i686: 'dc4a8ab10ade19c80018e1f815f9053b88dee6c5dc5d363e55181f8e59719469',
           x86_64: '0fa31104c75e229ae7988c193657df32f2c9d4dca8154d0f3b8a4081aeb2fa17',
        })
        $ver = 7
        break
      when '7.2'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.14-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.14-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.14-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.14-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'dc076b2e07da99b8ae26dd75b74e0dd39e23a6df8e82dfc2060b8a03f884ddd7',
           armv7l: 'dc076b2e07da99b8ae26dd75b74e0dd39e23a6df8e82dfc2060b8a03f884ddd7',
             i686: 'e75f54e42bb686ab2f8c49bd9c4cf080d507bc5e780515523453482667421fc1',
           x86_64: 'a13f6063587b19f9cc64dd9fcd9f96149033f184476c9282a38da7e855f4d900',
        })
        $ver = 7
        break
      when '7.3'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.1-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.1-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.1-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.1-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '49214ca99d98c7ff9a17a97a96df976d2b20f406ac0737a8d22ae16a3486774b',
           armv7l: '49214ca99d98c7ff9a17a97a96df976d2b20f406ac0737a8d22ae16a3486774b',
             i686: '58481f39c04d98d199e8864a5c28a68e45f94daa87ba3cfbdb8d8663733d096f',
           x86_64: 'b2fce9ddd14abb740e180bd1c0deeb46fe93f0c236a78dd0ee3f93da896b7b51',
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
  depends_on 'libzip'
  depends_on 'curl'
  depends_on 'exif'
  depends_on 'freetype'
  depends_on 'pcre'
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
