require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.5.6'
  source_url 'https://github.com/composer/composer/archive/1.5.6.tar.gz'
  source_sha256 '97a097078485eb95ecdda24026a6435f9495a445db74a1db8ecd3c80e9e1eb36'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.5.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.5.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.5.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.5.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '575a1efd5c73a93e12cea2c66734d7ca08674e31ef6906ccb959b6646faf54b8',
     armv7l: '575a1efd5c73a93e12cea2c66734d7ca08674e31ef6906ccb959b6646faf54b8',
       i686: '470645298a0e16c66f2cb574de77e819445a39f1a4003f1b849d7afe9080afaa',
     x86_64: 'f40f21c2465ac68d47c9755d6e785751138136265cde1f8c19b14694dd831ea4',
  })

  depends_on 'php7' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    system "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA384.hexdigest( File.read('composer-setup.php') ) == '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061' 
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "php composer-setup.php --install-dir=#{CREW_DEST_PREFIX}/bin --filename=composer --version=1.5.6"
  end
end
