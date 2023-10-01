require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '4.10.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/platformsh/legacy-cli/releases/download/v4.10.3/platform.phar'
  source_sha256 '5637426951cd219844f1ab4ec0685d3b597277141064a74a619f3baa93a3f7fb'

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.install 'platform.phar', "#{CREW_DEST_PREFIX}/bin/platform", mode: 0o755
  end
end
