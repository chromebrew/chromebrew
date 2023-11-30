require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '4.10.4'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/platformsh/legacy-cli/releases/download/v4.10.4/platform.phar'
  source_sha256 '956155f62daf7665d9306db3514276291160b4ca9ed4f2ca8491cf407e050860'

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.install 'platform.phar', "#{CREW_DEST_PREFIX}/bin/platform", mode: 0o755
  end
end
