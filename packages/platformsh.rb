require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '3.26.0'
  source_url 'https://github.com/platformsh/platformsh-cli/archive/v3.26.0.tar.gz'
  source_sha256 '57c639c587c5a0254c022cf9954054aa3092b8350d891aaf399ff4f3a614c5c0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/platformsh-3.26.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/platformsh-3.26.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/platformsh-3.26.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/platformsh-3.26.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '17cb068e71162c529129f21ace587cf83f0da33782726ca144416cabf95f44ae',
     armv7l: '17cb068e71162c529129f21ace587cf83f0da33782726ca144416cabf95f44ae',
       i686: 'd80488f79eef69722475c7bc1586510353f08918fb9aaf243045bd4e531913c0',
     x86_64: '361d33cec0c787d0dd07bef361af4fd68ce23d0c90c4df494a984ad2ea223a57',
  })

  depends_on 'php7' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    system "wget https://github.com/platformsh/platformsh-cli/releases/download/v3.26.0/platform.phar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('platform.phar') ) == '8343ce8235535f2c388a5ed0f0a321debc9a1838fd53c006c75445b2e099cbe9'
    system "install -Dm755 platform.phar #{CREW_DEST_PREFIX}/bin/platform"
  end
end
