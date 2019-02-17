require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.40-7.3.2'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "PHP version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the PHP version to install:"
    puts "5.6 = PHP 5.6.40"
    puts "7.0 = PHP 7.0.33"
    puts "7.1 = PHP 7.1.26"
    puts "7.2 = PHP 7.2.15"
    puts "7.3 = PHP 7.3.2"
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
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.15-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.15-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.15-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.15-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'f00628c247207dc2b17660507886609a332cc83a4aa29f4dd7e375cb3531c89e',
           armv7l: 'f00628c247207dc2b17660507886609a332cc83a4aa29f4dd7e375cb3531c89e',
             i686: '5e75ee1fe0b0da399c1f55b7ae0f45101ebf0275f1d14c9eaf6b55f8d43aaa7c',
           x86_64: 'a3ae79b8b427152365bff1009677d4036c627211cc85a44562019da5540f1b44',
        })
        $ver = 7
        break
      when '7.3'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.2-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.2-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.2-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.2-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'a572d287dafd36593aa5808fcd13e7221ce329220267b85a0f92b6dd4612bec0',
           armv7l: 'a572d287dafd36593aa5808fcd13e7221ce329220267b85a0f92b6dd4612bec0',
             i686: '64259ad36b4f8a5e08639e2f84b12a163f821aaa267f2dce26deb9fe0db0c5eb',
           x86_64: 'c438ee7d4867d154bb6bbb834a6425fd01757c7a344d2181e3e3427043cf7691',
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
