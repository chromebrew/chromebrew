require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '3.65.2'
  compatibility 'all'
  source_url "https://github.com/platformsh/platformsh-cli/archive/v#{version}.tar.gz"
  source_sha256 '03493b3d519948ff9b03131a2de43f57186897e793a02406d2bf13c266acfc7b'

  depends_on 'php74' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    system "wget https://github.com/platformsh/platformsh-cli/releases/download/v#{version}/platform.phar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('platform.phar') ) == '88b1bf5ec1242b9d88c179281e599f48798f759342cbb1ac4b9cba25cf3a0fd1'
    system "install -Dm755 platform.phar #{CREW_DEST_PREFIX}/bin/platform"
  end
end
