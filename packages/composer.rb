require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.5.2'
  source_url 'https://github.com/composer/composer/archive/1.5.2.tar.gz'
  source_sha256 'e8af65669563890364ec73ed57f589b1200f03fd86edc925a9961235aff5f54d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'php7' unless File.exists? '/usr/local/bin/php'

  def self.install
    system "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA384.hexdigest( File.read('composer-setup.php') ) == '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061' 
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "php composer-setup.php --install-dir=#{CREW_DEST_PREFIX}/bin --filename=composer --version=1.5.2"
  end
end
