require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '4.4.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/platformsh/legacy-cli/releases/download/v4.4.0/platform.phar'
  source_sha256 '22f5eaa2ee35a6688584a86db8846371e0076438873c76098b3e9fb2549c8e54'

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'platform.phar', "#{CREW_DEST_PREFIX}/bin/platform", mode: 0o755
  end
end
