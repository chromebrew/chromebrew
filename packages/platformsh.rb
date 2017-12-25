require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '3.26.0'
  source_url 'https://github.com/platformsh/platformsh-cli/archive/v3.26.0.tar.gz'
  source_sha256 '57c639c587c5a0254c022cf9954054aa3092b8350d891aaf399ff4f3a614c5c0'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'php7' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    system "wget https://github.com/platformsh/platformsh-cli/releases/download/v3.26.0/platform.phar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('platform.phar') ) == '8343ce8235535f2c388a5ed0f0a321debc9a1838fd53c006c75445b2e099cbe9'
    system "install -Dm755 platform.phar #{CREW_DEST_PREFIX}/bin/platform"
  end
end
