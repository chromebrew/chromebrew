require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.6.4'
  source_url 'https://github.com/composer/composer/archive/1.6.4.tar.gz'
  source_sha256 '8142ddd90845f75a0f4b04f3bef9f73bf2d2e19d86d700e68d01aaab6634320e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.6.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.6.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.6.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.6.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7d71030f8bfae28cd0bdb4af045c7c6d18be5b315fd99ba6eef40254d322d57c',
     armv7l: '7d71030f8bfae28cd0bdb4af045c7c6d18be5b315fd99ba6eef40254d322d57c',
       i686: '9651c87e0393ccb411944e9612f5f492f46a854d0a2befce2aa6c94dc6ed3355',
     x86_64: '23f43ed5ac044e6f992ef3c002e3fbc2dfa9d9af9bde9cf91e33e3066ad2fc2d',
  })

  depends_on 'php7' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    system "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA384.hexdigest( File.read('composer-setup.php') ) == '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061' 
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "php composer-setup.php --install-dir=#{CREW_DEST_PREFIX}/bin --filename=composer --version=1.6.4"
  end
end
