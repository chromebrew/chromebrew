require 'package'

class Libmypaint < Package
  description 'Libmypaint is MyPaint’s brushstroke rendering code, in a form that can be used by other programs.'
  homepage 'http://mypaint.org/'
  version '1.3.0'
  source_url 'https://github.com/mypaint/libmypaint/releases/download/v1.3.0/libmypaint-1.3.0.tar.xz'
  source_sha256 '6a07d9d57fea60f68d218a953ce91b168975a003db24de6ac01ad69dcc94a671'

  depends_on 'jsonc'
  depends_on 'gobject_introspection'
  depends_on 'glib'
  depends_on 'gegl'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "ldconfig"
  end
end
