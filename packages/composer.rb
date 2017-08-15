require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.4.2'
  source_url 'https://github.com/composer/composer/archive/1.4.2.tar.gz'
  source_sha256 'b5ebe7bfddf6e05be9ab071d5d53dc49e7c9059a12238460ec86e2e6ab722e06'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/composer-1.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/composer-1.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/composer-1.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/composer-1.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '21fc4be414c57b87f2fef310bd5686bf9afacf9b42d70eb965c3d2a2ebf8169d',
     armv7l: '21fc4be414c57b87f2fef310bd5686bf9afacf9b42d70eb965c3d2a2ebf8169d',
       i686: 'd9287ea3756417da202bc720f24a68942f0d8391e73ab2f403b4d28b243d5ec0',
     x86_64: 'a4df579e211c787e5d92c6102a6f3ee1017de8813ed5fe3482b5be0b0633f27e',
  })

  depends_on 'php7' unless File.exists? '/usr/local/bin/php'

  def self.install
    system "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA384.hexdigest( File.read('composer-setup.php') ) == '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410'
    system "php composer-setup.php --install-dir=/usr/local/bin --filename=composer --version=1.4.2"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp /usr/local/bin/composer #{CREW_DEST_DIR}/usr/local/bin/composer"
  end
end
