require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.40-7.3.11'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "PHP version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the PHP version to install:"
    puts "5.6 = PHP 5.6.40"
    puts "7.0 = PHP 7.0.33"
    puts "7.1 = PHP 7.1.33"
    puts "7.2 = PHP 7.2.24"
    puts "7.3 = PHP 7.3.11"
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
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.33-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.33-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.33-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.33-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '1a25458dca5188809187c717fc76864c71c896ac51032b4b5395875310f9bd6c',
           armv7l: '1a25458dca5188809187c717fc76864c71c896ac51032b4b5395875310f9bd6c',
             i686: 'ee2de86e059df317fff885d5e0df2db944890a675be5c23d81291779e23ac23a',
           x86_64: '4a61fb06d921969bf16d8154d68f34c2f5f0e2195503cb62fc964f7908ed962e',
        })
        $ver = 7
        break
      when '7.2'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.24-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.24-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.24-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.24-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '703dcea04ae36128de998205d2b083f28e662caba8220e932cdc59700bcf1818',
           armv7l: '703dcea04ae36128de998205d2b083f28e662caba8220e932cdc59700bcf1818',
             i686: '2d2b94253d0211c71cd255d50fe93674ef1309584a5b228a8fd523a2722014a9',
           x86_64: '1ab757a1ad60ec328b785da1e94244444a5507a53ca59eb9428eb586e3fec484',
        })
        $ver = 7
        break
      when '7.3'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.11-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.11-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.11-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.11-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'c6d23c09318d763fb18149c0f9213f2dd5d0532ae08a688560144a57dfc0911a',
           armv7l: 'c6d23c09318d763fb18149c0f9213f2dd5d0532ae08a688560144a57dfc0911a',
             i686: '6b63be58066cc745ffa88b5fd34a5c31394f104d5d447f5bdf509761f2e33a6c',
           x86_64: '6f6ef69344946e5985ddf5e0b179c6803b1567801319395079199f8e3714ad53',
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
