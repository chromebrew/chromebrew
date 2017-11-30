require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.5.2'
  source_url 'https://github.com/composer/composer/archive/1.5.2.tar.gz'
  source_sha256 'e8af65669563890364ec73ed57f589b1200f03fd86edc925a9961235aff5f54d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.5.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.5.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.5.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.5.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a6b6f5e5248de63e88af047b9d70fb2a614d0d759b85f92ba3386062b4a7441b',
     armv7l: 'a6b6f5e5248de63e88af047b9d70fb2a614d0d759b85f92ba3386062b4a7441b',
       i686: 'a208dc47105d4417255de03a5ab972aa8d1fff5a2e3e0908e587f71a021a91fb',
     x86_64: '0ae47d615f662c3d0b78c96c9f5750e9f04b4e0ce45dee2caa5080f4b6740056',
  })

  depends_on 'php7' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    system "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA384.hexdigest( File.read('composer-setup.php') ) == '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061' 
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "php composer-setup.php --install-dir=#{CREW_DEST_PREFIX}/bin --filename=composer --version=1.5.2"
  end
end
