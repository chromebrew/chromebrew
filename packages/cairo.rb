require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.14.12'
  source_url 'https://www.cairographics.org/releases/cairo-1.14.12.tar.xz'
  source_sha256 '8c90f00c500b2299c0a323dd9beead2a00353752b2092ead558139bd67f7bf16'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libpng'
  depends_on 'pixman'
  depends_on 'fontconfig' # pango requires cairo with fontconfig
  depends_on 'automake'
  
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
