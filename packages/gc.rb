require 'package'

class Gc < Package
  description 'A garbage collector for C and C++.'
  homepage 'http://www.hboehm.info/gc/'
  version '7.6.0'
  source_url 'http://www.hboehm.info/gc/gc_source/gc-7.6.0.tar.gz'
  source_sha256 'a14a28b1129be90e55cd6f71127ffc5594e1091d5d54131528c24cd0c03b7d90'

  depends_on 'libatomic_ops'
  depends_on 'libtool'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "libtool --finish /usr/local/lib"
  end
end
