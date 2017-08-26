require 'package'

class Misctools < Package
  description 'The misctools package is a collection of small but useful utilities.'
  homepage 'http://www.hyperrealm.com/main.php?s=misctools'
  version '2.5.5'
  source_url 'http://www.hyperrealm.com/misctools/misctools-2.5.5.tar.bz2'
  source_sha256 '4eb5913566da3e243ebd9cab499f927a2d46a2191baa51b810214f83eebb3ae9'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cbase'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
