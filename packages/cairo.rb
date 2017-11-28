require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.14.10-2'
  source_url 'https://www.cairographics.org/releases/cairo-1.14.10.tar.xz'
  source_sha256 '7e87878658f2c9951a14fc64114d4958c0e65ac47530b8ac3078b2ce41b66a09'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libpng'
  depends_on 'pixman'
  depends_on 'fontconfig' # pango requires cairo with fontconfig

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-xlib'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
