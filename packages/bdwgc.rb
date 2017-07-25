require 'package'

class Bdwgc < Package
  description 'The Boehm-Demers-Weiser conservative C/C++ Garbage Collecto'
  homepage 'https://github.com/ivmai/bdwgc'
  version '7.6.0'
  source_url 'https://github.com/ivmai/bdwgc/files/1005477/gc-7.6.0.tar.gz'
  source_sha256 'a14a28b1129be90e55cd6f71127ffc5594e1091d5d54131528c24cd0c03b7d90'

  depends_on 'libatomic_ops'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end