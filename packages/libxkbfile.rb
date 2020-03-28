require 'package'

class Libxkbfile < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.1.0'
  source_url 'https://www.x.org/archive/individual/lib/libxkbfile-1.1.0.tar.bz2'
  source_sha256 '758dbdaa20add2db4902df0b1b7c936564b7376c02a0acd1f2a331bd334b38c7'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
