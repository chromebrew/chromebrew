require 'package'

class Wp_cli < Package
  description 'The command line interface for WordPress'
  homepage 'https://wp-cli.org/'
  version '2.9.0'
  license 'LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/wp-cli/wp-cli/releases/download/v#{version}/wp-cli-#{version}.phar"
  source_sha256 'af6b7ccc21ed0907cb504db5a059f0e120117905a6017bfdd4375cee3c93d864'

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.install "wp-cli-#{version}.phar", "#{CREW_DEST_PREFIX}/bin/wp", mode: 0o755
  end
end
