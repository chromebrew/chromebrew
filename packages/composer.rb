require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.6.5'
  source_url 'https://github.com/composer/composer/archive/1.6.5.tar.gz'
  source_sha256 'da4f81a53f845ed0ac4d77fb6d57e3644002b660f4c31cdd14a5a9c340db9776'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.6.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.6.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.6.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/composer-1.6.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '13b02d5d54d773cc03d6f94392151d5957364b76350a8e991a1a3e5762a45c16',
     armv7l: '13b02d5d54d773cc03d6f94392151d5957364b76350a8e991a1a3e5762a45c16',
       i686: '0451a78d65547a48f3056ae78ffb8d6452f05ca6acaaf91f75462ee91949e640',
     x86_64: 'd010d91133dd3097ed323f79a3314d110ce04791c3f3c9e31660b7306aa38c31',
  })

  depends_on 'php7' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    system "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA384.hexdigest( File.read('composer-setup.php') ) == '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061' 
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "php composer-setup.php --install-dir=#{CREW_DEST_PREFIX}/bin --filename=composer --version=1.6.5"
  end
end
