require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '4.17.0'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/platformsh/legacy-cli/releases/download/v4.17.0/platform.phar'
  source_sha256 '61119e2562731648296ed81cf05f610c7c972e0ba99811ac53adae9e94f50619'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.install 'platform.phar', "#{CREW_DEST_PREFIX}/bin/platform", mode: 0o755
  end
end
