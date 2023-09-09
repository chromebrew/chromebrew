require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '4.9.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/platformsh/legacy-cli/releases/download/v4.9.0/platform.phar'
  source_sha256 'c52a0dca5026626f2707a7dabc0cf565368e62b843cfd4e1af9e31dbd8389d76'

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.install 'platform.phar', "#{CREW_DEST_PREFIX}/bin/platform", mode: 0o755
  end
end
