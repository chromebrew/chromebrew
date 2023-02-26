require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '4.1.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/platformsh/legacy-cli/releases/download/v4.1.2/platform.phar'
  source_sha256 'd4aff4ca47a18f24a5510031fd9576e4e1541150c25b297410b44a5bd5073d9a'

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'platform.phar', "#{CREW_DEST_PREFIX}/bin/platform", mode: 0o755
  end
end
