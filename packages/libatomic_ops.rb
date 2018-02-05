require 'package'

class Libatomic_ops < Package
  description 'Atomic memory update operations portable implementation'
  homepage 'https://github.com/ivmai/libatomic_ops'
  version '7.6.2'
  source_url 'https://github.com/ivmai/libatomic_ops/archive/v7.6.2.tar.gz'
  source_sha256 'f0290ebe34bc8f62d153aab4b644e4365b82a63820f1ff861282d460e44f10f6'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./autogen.sh"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
