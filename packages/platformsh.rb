require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '3.19.0'
  source_url 'https://github.com/platformsh/platformsh-cli/archive/v3.19.0.tar.gz'
  source_sha256 'c8f79f2141bdf5f6bed11376da773f9d90e8b3ddc059a1159cf11a0929aa6aff'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/platformsh-3.19.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/platformsh-3.19.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/platformsh-3.19.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/platformsh-3.19.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1fa8e9f4c8f85ee29e6fc43120d725201afe4e39b2a87104d599a742beca35fa',
     armv7l: '1fa8e9f4c8f85ee29e6fc43120d725201afe4e39b2a87104d599a742beca35fa',
       i686: '7329085c462c01e75ae432ec1edd9e1ba3467ef285e2da50da5c4d2c3e7092ac',
     x86_64: 'c128bf0ba9aad4dcbeb5a54ba8e45b75a44a4e7c4824392e23cb6c2e3c0c0098',
  })

  depends_on 'php7' unless File.exists? '/usr/local/bin/php'

  def self.install
    system "wget https://github.com/platformsh/platformsh-cli/releases/download/v3.19.0/platform.phar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('platform.phar') ) == 'ca4080182458fb18244bf8d93a36695146a737eb5acd35be56d65161af5a0dd7'
    system "chmod +x platform.phar"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp platform.phar #{CREW_DEST_DIR}/usr/local/bin/platform"
  end
end
