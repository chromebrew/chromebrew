require 'package'

class Acl < Package
  description 'Commands for Manipulating POSIX Access Control Lists.'
  homepage 'http://savannah.nongnu.org/projects/acl'
  version '2.2.53'
  source_url 'https://bigsearcher.com/mirrors/nongnu/acl/acl-2.2.53.tar.gz'
  source_sha256 '06be9865c6f418d851ff4494e12406568353b891ffe1f596b34693c387af26c7'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'attr'

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
