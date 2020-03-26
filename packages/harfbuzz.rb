require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  version '2.6.4'
  source_url 'https://github.com/harfbuzz/harfbuzz/releases/download/2.6.4/harfbuzz-2.6.4.tar.xz'
  source_sha256 '9413b8d96132d699687ef914ebb8c50440efc87b3f775d25856d7ec347c03c12'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glib'
  depends_on 'freetype_sub'
  depends_on 'six' => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
