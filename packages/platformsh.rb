require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '4.7.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/platformsh/legacy-cli/releases/download/v4.7.2/platform.phar'
  source_sha256 '7df2eb82ab34d8f6e9de9e7a572c8e65a33463ae9ed34cc8d2a154accb7ec768'

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.install 'platform.phar', "#{CREW_DEST_PREFIX}/bin/platform", mode: 0o755
  end
end
