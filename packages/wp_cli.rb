require 'package'

class Wp_cli < Package
  description 'The command line interface for WordPress'
  homepage 'https://wp-cli.org/'
  version '2.11.0'
  license 'LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/wp-cli/wp-cli/releases/download/v#{version}/wp-cli-#{version}.phar"
  source_sha256 'a39021ac809530ea607580dbf93afbc46ba02f86b6cffd03de4b126ca53079f6'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.install "wp-cli-#{version}.phar", "#{CREW_DEST_PREFIX}/bin/wp", mode: 0o755
  end
end
