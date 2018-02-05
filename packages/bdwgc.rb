require 'package'

class Bdwgc < Package
  description 'The Boehm-Demers-Weiser conservative C/C++ Garbage Collecto'
  homepage 'https://github.com/ivmai/bdwgc'
  version '7.6.4'
  source_url 'https://github.com/ivmai/bdwgc/archive/v7.6.4.tar.gz'
  source_sha256 '1f85bf6d4aaa3fb12fe0178b13d9685e2d0c3a4d115dea5f831c54deafa3f6db'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libatomic_ops'

  def self.build
      system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
