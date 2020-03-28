require 'package'

class Libxcb < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.14'
  source_url 'https://xcb.freedesktop.org/dist/libxcb-1.14.tar.xz'
  source_sha256 'a55ed6db98d43469801262d81dc2572ed124edc3db31059d4e9916eb9f844c34'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27' => :build
  depends_on 'xcb_proto'
  depends_on 'libxau'
  depends_on 'pthread_stubs'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
