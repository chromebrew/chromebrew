require 'package'

class Miniupnpc < Package
  description 'UPnP IGD client lightweight library'
  homepage 'http://miniupnp.free.fr/'
  version '2.0'
  source_url 'http://miniupnp.free.fr/files/download.php?file=miniupnpc-2.0.tar.gz'
  source_sha256 'd434ceb8986efbe199c5ca53f90ed53eab290b1e6d0530b717eb6fa49d61f93b'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "sed -i '139s,/usr,,' Makefile"
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}"
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
