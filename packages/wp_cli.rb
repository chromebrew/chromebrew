require 'package'

class Wp_cli < Package
  description 'The command line interface for WordPress'
  homepage 'https://wp-cli.org/'
  version '1.4.1'
  source_url 'https://raw.githubusercontent.com/wp-cli/wp-cli/release-1-4-1/VERSION'
  source_sha256 '7d072b48526b023950e4c48db01e8c273554a6401119f5691e7589ba9bc65d9d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'php7' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.build
    system 'wget https://github.com/wp-cli/wp-cli/releases/download/v1.4.1/wp-cli-1.4.1.phar'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('wp-cli-1.4.1.phar') ) == '325924cf161856f9478f2a154572698ecb5d1054e620843b9c43a7baf4e5ce3b'
  end

  def self.install
    system "install -Dm755 wp-cli-1.4.1.phar #{CREW_DEST_PREFIX}/bin/wp"
  end
end
