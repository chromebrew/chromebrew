require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '3.52.2'
  source_url 'https://github.com/platformsh/platformsh-cli/archive/v3.52.2.tar.gz'
  source_sha256 '574e3b4b99224b39833409ce2972a6738844b22e3d4f035ce6f6e8cef527dfea'

  depends_on 'php' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    system "wget https://github.com/platformsh/platformsh-cli/releases/download/v#{version}/platform.phar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('platform.phar') ) == 'aa420d0f2cf1efd90efb464dd0d7d544c1ba5be381e79eb22a86afb6f17bd181'
    system "install -Dm755 platform.phar #{CREW_DEST_PREFIX}/bin/platform"
  end
end
