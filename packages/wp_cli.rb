require 'package'

class Wp_cli < Package
  description 'The command line interface for WordPress'
  homepage 'https://wp-cli.org/'
  version '1.4.1'
  source_url 'https://raw.githubusercontent.com/wp-cli/wp-cli/release-1-4-1/VERSION'
  source_sha256 '7d072b48526b023950e4c48db01e8c273554a6401119f5691e7589ba9bc65d9d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wp_cli-1.4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wp_cli-1.4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wp_cli-1.4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wp_cli-1.4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '50fa957eda866cdc311e49c83a172c64e745ac0b0a85a2e1dd78d7c9a6ee7e0b',
     armv7l: '50fa957eda866cdc311e49c83a172c64e745ac0b0a85a2e1dd78d7c9a6ee7e0b',
       i686: '6f4c0a3db8806ab2209e30de7ec43b8aa325ef1d5875cd66bc3831bbe0bbb119',
     x86_64: 'caa9a556ef4070dc74509f4d0f1b87620e4ce19263c8c85cf5c3b84e059dc84d',
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
