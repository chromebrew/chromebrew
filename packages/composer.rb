require 'package'

class Composer < Package
  description 'Dependency Manager for PHP'
  homepage 'https://getcomposer.org/'
  version '1.4.2'
  source_url 'https://github.com/composer/composer/archive/1.4.2.tar.gz'
  source_sha1 'd0179a967011891c2c1e6067acc1faa1e8a8c81c'

  depends_on 'php7' unless File.exists? '/usr/local/bin/php'

  def self.install
    system "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA384.hexdigest( File.read('composer-setup.php') ) == '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410'
    system "php composer-setup.php --install-dir=/usr/local/bin --filename=composer --version=1.4.2"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp /usr/local/bin/composer #{CREW_DEST_DIR}/usr/local/bin/composer"
  end
end
