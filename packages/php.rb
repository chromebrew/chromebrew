require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.40-7.3.3'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "PHP version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the PHP version to install:"
    puts "5.6 = PHP 5.6.40"
    puts "7.0 = PHP 7.0.33"
    puts "7.1 = PHP 7.1.27"
    puts "7.2 = PHP 7.2.16"
    puts "7.3 = PHP 7.3.3"
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
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.27-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.27-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.27-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.27-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '19e231864e33ac1f7d676ad88d042b87998f7b29bf659dd6f8f5c977a3a7d5b8',
           armv7l: '19e231864e33ac1f7d676ad88d042b87998f7b29bf659dd6f8f5c977a3a7d5b8',
             i686: '4810da96a1325ad9a3f1212a86636625ed0ea2b07db0ec47af420e5002e16376',
           x86_64: '70e8e4ea5c7d407e63b4a4acabd450cec8844ea488bea7ec843f72ada2280d4c',
        })
        $ver = 7
        break
      when '7.2'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.16-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.16-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.16-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.16-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '369005b949a43d6c2206e92d3cf9509f3adcc82aedc183282cdaae75531c1af0',
           armv7l: '369005b949a43d6c2206e92d3cf9509f3adcc82aedc183282cdaae75531c1af0',
             i686: '565ee9d8e5eb4dc6a4c7b5f20a5f879a63d4493d60af0fcbc12e58b2502cd886',
           x86_64: 'e88d57c9ae18d50f3e91bc4973efb2f5d253cfdd764da894305254e20ab91b4d',
        })
        $ver = 7
        break
      when '7.3'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.3-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.3-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.3-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.3-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'a453903edea22a488a4277ee58c6a3e1adfaa2e9536545c10d8199651c98bc54',
           armv7l: 'a453903edea22a488a4277ee58c6a3e1adfaa2e9536545c10d8199651c98bc54',
             i686: 'bcc55c2ba85eae16af280990edf5067d38fef46e892682a2234b1b76af7f32b1',
           x86_64: '5bc9a88a0f5349565922796b9cd1aaa6a95ade072691cb6d0847094fa26c8a55',
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
