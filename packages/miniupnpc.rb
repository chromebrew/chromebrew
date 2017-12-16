require 'package'

class Miniupnpc < Package
  description 'UPnP IGD client lightweight library'
  homepage 'http://miniupnp.free.fr/'
  version '2.0.20171212'
  source_url 'http://miniupnp.free.fr/files/download.php?file=miniupnpc-2.0.20171212.tar.gz'
  source_sha256 '6eda4744fe26a3c7fb626e3044e9a88af145f88d29a8c2a41ca8384a25482e0d'

  def self.build
    system "sed -i '139s,/usr,,' Makefile"
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}"
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
