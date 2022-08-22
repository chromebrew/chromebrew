require 'package'

class Wp_cli < Package
  description 'The command line interface for WordPress'
  homepage 'https://wp-cli.org/'
  version '2.6.0'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.build
    system "curl -#LO https://github.com/wp-cli/wp-cli/releases/download/v#{version}/wp-cli-#{version}.phar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest(File.read("wp-cli-#{version}.phar")) == 'd166528cab60bc8229c06729e7073838fbba68d6b2b574504cb0278835c87888'
  end

  def self.install
    system "install -Dm755 wp-cli-#{version}.phar #{CREW_DEST_PREFIX}/bin/wp"
  end
end
