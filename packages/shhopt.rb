require 'package'

class Shhopt < Package
  description 'C-functions for parsing command line options, both traditional one-character options, and GNU\'ish --long-options.'
  homepage 'http://shh.thathost.com/pub-unix/#sshopt'
  version '1.1.7-1'
  source_url 'http://shh.thathost.com/pub-unix/files/shhopt-1.1.7.tar.gz'
  source_sha256 'bae94335124efa6fcc2f0a55cabd68c9c90be935bcdb8054d7e5188e0d5da679'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "make"
  end

  def self.install
    system "make", "INSTBASEDIR=#{CREW_DEST_PREFIX}", "install"
  end
end
