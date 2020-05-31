require 'package'

class Wp_cli < Package
  description 'The command line interface for WordPress'
  homepage 'https://wp-cli.org/'
  version '2.4.0'
  source_url 'https://raw.githubusercontent.com/wp-cli/wp-cli/v2.4.0/VERSION'
  source_sha256 '2ad7b0c3f0ede58c3165b7a8a5479e890a758d39bfe8683eaef50ce6afad7232'

  depends_on 'php7' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.build
    system "wget https://github.com/wp-cli/wp-cli/releases/download/v#{version}/wp-cli-#{version}.phar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("wp-cli-#{version}.phar") ) == '139dcc86ed39ef751679efbdaf57a53528f1afda972c4e3622667cc27397b540'
  end

  def self.install
    system "install -Dm755 wp-cli-#{version}.phar #{CREW_DEST_PREFIX}/bin/wp"
  end
end
