require 'package'

class Wp_cli < Package
  description 'The command line interface for WordPress'
  homepage 'https://wp-cli.org/'
  version '2.7.0'
  license 'LGPL-3'
  compatibility 'all'
  source_url "https://github.com/wp-cli/wp-cli/releases/download/v#{version}/wp-cli-#{version}.phar"
  source_sha256 '4445500eaf741b1c127c60ed2a8c54e1c4c8f54cd56aaae842d38bf459d282fa'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install "wp-cli-#{version}.phar", "#{CREW_DEST_PREFIX}/bin/wp", mode: 0o755
  end
end
