require 'package'

class Sshrc < Package
  description 'bring your .bashrc, .vimrc, etc. with you when you ssh'
  homepage 'https://github.com/Russell91/sshrc'
  version '0.6.1'
  compatibility 'all'
  source_url 'https://github.com/Russell91/sshrc/archive/0.6.1.tar.gz'
  source_sha256 'e849ff19319381548011a9bdf1e33abc6eba3dc6a910c4226e6981d75d5564dd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sshrc-0.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sshrc-0.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sshrc-0.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sshrc-0.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e52ec8b2ea9be7d694bcc676059a8f5bfd35a9a05dbde317eff1bfb992ed9d37',
     armv7l: 'e52ec8b2ea9be7d694bcc676059a8f5bfd35a9a05dbde317eff1bfb992ed9d37',
       i686: 'c75c2b8cdd3996299d91195ed16fe727a72add0c718df10baf9aa6b009737f31',
     x86_64: '7d940b4d6e59da0868081379314f31a923bb37ca9cfc934c23e62892a24750b9',
  })

  def self.install
    system "install -Dm755 sshrc #{CREW_DEST_PREFIX}/bin/sshrc"
  end
end
