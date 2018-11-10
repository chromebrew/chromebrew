require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.38-7.2.12'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "Php version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the php version to install:"
    puts "5.6 = PHP 5.6.38"
    puts "7.0 = PHP 7.0.32"
    puts "7.1 = PHP 7.1.24"
    puts "7.2 = PHP 7.2.12"
    puts "  0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '5.6'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.38-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.38-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.38-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php5-5.6.38-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '6fa6a12b50a565c1934f2556011aa9107058adc7af2b8cf44567d3c324c34ce7',
           armv7l: '6fa6a12b50a565c1934f2556011aa9107058adc7af2b8cf44567d3c324c34ce7',
             i686: '7e652da5133743cc170a1bd2ecc2ecc9c2f14ff66580cfc7e84c5daba96922f3',
           x86_64: 'ce5b6e291a502f632a125ada7693f423cab96ed137bd52ac3a0538523b3caf01',
        })
        $ver = 5
        break
      when '7.0'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.32-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.32-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.32-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.0.32-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'b381413c87bc2d262ea443b2acdbcd90ba2c2840b6423954548f845aa08264e0',
           armv7l: 'b381413c87bc2d262ea443b2acdbcd90ba2c2840b6423954548f845aa08264e0',
             i686: 'fa06779f527ee0e50ae3b0f13b0e09eea916786443fef769b231f603eaa9192d',
           x86_64: 'df3a185813a7c7bd1512c430d047d8e8c947b296b5ddbd74777e7e457703261f',
        })
        $ver = 7
        break
      when '7.1'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.24-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.24-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.24-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.24-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '9b0598def745f33db755791721c594ccf3cace3de54f8d24c32df07aac616e28',
           armv7l: '9b0598def745f33db755791721c594ccf3cace3de54f8d24c32df07aac616e28',
             i686: '60c31d2303610d96a1c9530ca8b442d978289b3b4e50961267ef0eafc3d8981e',
           x86_64: 'd8b7494f19c04967553f5601804ad7864d3ec47204e6bc23ab4d6ffa2fc6e980',
        })
        $ver = 7
        break
      when '7.2'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.12-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.12-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.12-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.12-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '09132b4326e34418695af2566c356591048583b1c286b1235aac3a1030431161',
           armv7l: '09132b4326e34418695af2566c356591048583b1c286b1235aac3a1030431161',
             i686: '206b65c8b6051dbabbc4c97f08c95d79bea8e9a35f7eca671dacdee7eaf3cffb',
           x86_64: '156a3d95387a2ea0bf6367935b71b63c281e1d663370d3ba2848717db956e3f3',
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
