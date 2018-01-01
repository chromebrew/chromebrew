require 'package'

class Bdwgc < Package
  description 'The Boehm-Demers-Weiser conservative C/C++ Garbage Collecto'
  homepage 'https://github.com/ivmai/bdwgc'
  version '7.6.2'
  source_url 'https://github.com/ivmai/bdwgc/releases/download/v7.6.2/gc-7.6.2.tar.gz'
  source_sha256 'bd112005563d787675163b5afff02c364fc8deb13a99c03f4e80fdf6608ad41e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libatomic_ops'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end