require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.5.6'
  source_url 'https://github.com/composer/composer/archive/1.5.6.tar.gz'
  source_sha256 '97a097078485eb95ecdda24026a6435f9495a445db74a1db8ecd3c80e9e1eb36'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'php7' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    system "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA384.hexdigest( File.read('composer-setup.php') ) == '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061' 
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "php composer-setup.php --install-dir=#{CREW_DEST_PREFIX}/bin --filename=composer --version=1.5.6"
  end
end
