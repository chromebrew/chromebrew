require 'package'

class Banner < Package
  description 'An implementation of the traditional Unix-program used to display large characters.'
  homepage 'http://shh.thathost.com/pub-unix/#banner'
  version '1.3.2'
  source_url 'http://shh.thathost.com/pub-unix/files/banner-1.3.2.tar.gz'
  source_sha256 '0dc0ac0667b2e884a7f5ad3e467af68cd0fd5917f8c9aa19188e6452aa1fc6d5'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'shhmsg'
  depends_on 'shhopt'

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
