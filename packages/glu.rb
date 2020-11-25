require 'package'

class Glu < Package
  description 'Mesa OpenGL Utility library'
  version '9.0.1'
  compatibility 'all'
  source_url 'https://mesa.freedesktop.org/archive/glu/glu-9.0.1.tar.xz'
  source_sha256 'fb5a4c2dd6ba6d1c21ab7c05129b0769544e1d68e1e3b0ffecb18e73c93055bc'

  depends_on 'mesa'

  def self.build
    system "./configure #{CREW_OPTIONS}  --disable-static"
    system 'make'
  end
  
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
