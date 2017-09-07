require 'package'

class Misctools < Package
  description 'The misctools package is a collection of small but useful utilities.'
  homepage 'http://www.hyperrealm.com/oss_misctools.shtml'
  version '2.6'
  source_url 'http://www.hyperrealm.com/packages/misctools-2.6.tar.bz2'
  source_sha256 'b1f13bb3af52ffffddf45efd8c10f942a8c1548352b7878668fbbf27ffa68e1a'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cbase'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
