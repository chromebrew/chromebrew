require 'package'

class Wp_cli < Package
  description 'The command line interface for WordPress'
  homepage 'https://wp-cli.org/'
  version '2.3.0'
  source_url 'https://raw.githubusercontent.com/wp-cli/wp-cli/v2.3.0/VERSION'
  source_sha256 'a42caf4a54bbbe27aa45b6efbc6356c5e299b19763e728b6cdb7201b02ebbe36'

  depends_on 'php7' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.build
    system "wget https://github.com/wp-cli/wp-cli/releases/download/v#{version}/wp-cli-#{version}.phar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("wp-cli-#{version}.phar") ) == '3c5edf945846f650846b973a22645823c7f5e00b0e393f921397d26ee11f3770'
  end

  def self.install
    system "install -Dm755 wp-cli-#{version}.phar #{CREW_DEST_PREFIX}/bin/wp"
  end
end
