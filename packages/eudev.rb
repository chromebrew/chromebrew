require 'package'

class Eudev < Package
  description 'Gentoo standalone udev'
  homepage 'https://wiki.gentoo.org/wiki/Project:Eudev'
  version '3.2.4'
  source_url 'https://github.com/gentoo/eudev/archive/v3.2.4.tar.gz'
  source_sha256 'a68871be55aecb977ae4a206b5ce5a868a722e025f37387d1a702a409933bbeb'

  depends_on 'util_linux'
  depends_on 'm4'
  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'libxslt'
  depends_on 'libtool'
  depends_on 'gperf'

  def self.build
    system 'autoreconf -f -i -s'
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
