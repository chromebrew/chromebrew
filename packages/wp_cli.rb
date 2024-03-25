require 'package'

class Wp_cli < Package
  description 'The command line interface for WordPress'
  homepage 'https://wp-cli.org/'
  version '2.10.0'
  license 'LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/wp-cli/wp-cli/releases/download/v2.10.0/wp-cli-2.10.0.phar'
  source_sha256 '4c6a93cecae7f499ca481fa7a6d6d4299c8b93214e5e5308e26770dbfd3631df'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.install "wp-cli-#{version}.phar", "#{CREW_DEST_PREFIX}/bin/wp", mode: 0o755
  end
end
