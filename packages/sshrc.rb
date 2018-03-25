require 'package'

class Sshrc < Package
  description 'bring your .bashrc, .vimrc, etc. with you when you ssh'
  homepage 'https://github.com/Russell91/sshrc'
  version '0.6.1'
  source_url 'https://github.com/Russell91/sshrc/archive/0.6.1.tar.gz'
  source_sha256 'e849ff19319381548011a9bdf1e33abc6eba3dc6a910c4226e6981d75d5564dd'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 sshrc #{CREW_DEST_PREFIX}/bin/sshrc"
  end
end
