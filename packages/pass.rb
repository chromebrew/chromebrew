require 'package'

class Pass < Package
  description "The standard unix password manager"
  homepage 'https://www.passwordstore.org/'
  version '1.7.1'
  source_url 'https://git.zx2c4.com/password-store/snapshot/password-store-1.7.1.tar.xz'
  source_sha256 'f6d2199593398aaefeaa55e21daddfb7f1073e9e096af6d887126141e99d9869'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gnupg'

  def self.install
    system  "make", "PREFIX=/usr/local", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
