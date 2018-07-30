require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.37-7.2.8'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "Php version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the php version to install:"
    puts "5.6 = PHP 5.6.37"
    puts "7.0 = PHP 7.0.31"
    puts "7.1 = PHP 7.1.20"
    puts "7.2 = PHP 7.2.8"
    puts "  0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '5.6'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.37-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.37-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.37-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.37-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '993d11d53a2f8cc0313848e318e52471882f7ff73d8acff695ebfa97ccaf52ee',
           armv7l: '993d11d53a2f8cc0313848e318e52471882f7ff73d8acff695ebfa97ccaf52ee',
             i686: 'ff37cce3c0c7ff128ba08201994dfa355dc3527431811b3ab41c6c579949fe43',
           x86_64: '51f08048091118b86a07a61708a388cd1312bca005dc7ba4bc06b11d20517b5c',
        })
        $ver = 5
        break
      when '7.0'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.31-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.31-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.31-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.31-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '53950096d9dd7563ed2a5e4a054955eca8661ffc2b80d4420e6f6f62df884cfd',
           armv7l: '53950096d9dd7563ed2a5e4a054955eca8661ffc2b80d4420e6f6f62df884cfd',
             i686: 'cfaa7df8f66a0767f925577c987169758fff780056c38f3b48af69015d2593c1',
           x86_64: '3677334fa1b292c54eab74e687e88686d0a421476c3e2cb460a0095c075a033c',
        })
        $ver = 7
        break
      when '7.1'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.20-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.20-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.20-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.20-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '0af95db3237b5b5e7237a0b991b8d06720554f2c0feefdfdfe3c8e3dee00169a',
           armv7l: '0af95db3237b5b5e7237a0b991b8d06720554f2c0feefdfdfe3c8e3dee00169a',
             i686: '795a437d7b433cef5d3ac2d6a5695412f495dcf81f86bdd843c1c099d9c69ce6',
           x86_64: 'da5bf231427f62dceee26418c3ad08ce7a18e1bf9cf20f39a8ff6c2aa33b9dc9',
        })
        $ver = 7
        break
      when '7.2'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.8-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.8-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.8-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.8-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '01f39e3bb42b9f00f10417b53abd5802922625c846c601cdd1890118a4cb791e',
           armv7l: '01f39e3bb42b9f00f10417b53abd5802922625c846c601cdd1890118a4cb791e',
             i686: '6d404e5f100005d9e8ed5b08cdc70e0294155b65c0b2fe1c80fbbef227e632b8',
           x86_64: '8f0c18b8f9f2a2aa52af6f8fc4af55a755fe110bdaa6c50dff42dfcbff4307fa',
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
