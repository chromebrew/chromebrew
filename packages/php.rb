require 'package'

class Php < Package
  description 'PHP is a popular general-purpose scripting language that is especially suited to web development.'
  homepage 'http://www.php.net/'
  version '5.6.40-7.3.6'

  if ARGV[0] == 'install'
    phpver = `php -v 2> /dev/null | head -1 | cut -d' ' -f2`.chomp
    abort "PHP version #{phpver} already installed.".lightgreen unless "#{phpver}" == ""
    puts
    puts "Enter the PHP version to install:"
    puts "5.6 = PHP 5.6.40"
    puts "7.0 = PHP 7.0.33"
    puts "7.1 = PHP 7.1.30"
    puts "7.2 = PHP 7.2.19"
    puts "7.3 = PHP 7.3.6"
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
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.30-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.30-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.30-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.1.30-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: 'f3bf42a534b4b56b07884d3df14e09ea093affcf9ccca3540f47fe909b141a21',
           armv7l: 'f3bf42a534b4b56b07884d3df14e09ea093affcf9ccca3540f47fe909b141a21',
             i686: 'de038c6cd6d67a7ae07cf8b0abacc215f799a4d731fb5560df93910c6472cf94',
           x86_64: 'c3a4e1dd85c0f383fbf868e7877421fba9848c4b6d1900612ba141cba968d2bc',
        })
        $ver = 7
        break
      when '7.2'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.19-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.19-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.19-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.2.19-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '21d98536ddaffc63ae6dd8b620f278e0a2886b21a11789584a391ae09b95a554',
           armv7l: '21d98536ddaffc63ae6dd8b620f278e0a2886b21a11789584a391ae09b95a554',
             i686: 'e3c7ebd67a95348f4213cf0f87af80fba9213161e978c349edbda9ea55831799',
           x86_64: 'd45341eac77d57f91d72509de9c98a0bfc0018b74e3ac0103075a2e66118b87c',
        })
        $ver = 7
        break
      when '7.3'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.6-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.6-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.6-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/php7-7.3.6-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '8483fc02476688ae24151ee5c68a4232d27db4666bf8b38c96ede735348b5305',
           armv7l: '8483fc02476688ae24151ee5c68a4232d27db4666bf8b38c96ede735348b5305',
             i686: '0ed0f04f51244e2177a553a57bc78d38685213628cc0dbc645e142d15b3c58f7',
           x86_64: '20ee5c4bfab8385ebb67494628d5fc9acb72bfc68ff0f26a1411f57e3b0d8827',
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
