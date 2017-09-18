require 'package'

class Poppler < Package
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  version '0.59.0'
  source_url 'https://poppler.freedesktop.org/poppler-0.59.0.tar.xz'
  source_sha256 'a3d626b24cd14efa9864e12584b22c9c32f51c46417d7c10ca17651f297c9641'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
