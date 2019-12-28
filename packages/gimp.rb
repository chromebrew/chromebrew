require 'package'

class Gimp < Package
  description 'GIMP is a cross-platform image editor available for GNU/Linux, OS X, Windows and more operating systems.'
  homepage 'https://www.gimp.org/'
  version '2.10.14'
  source_url 'https://download.gimp.org/pub/gimp/v2.10/gimp-2.10.14.tar.bz2'
  source_sha256 'df9b0f11c2078eea1de3ebc66529a5d3854c5e28636cd25a8dd077bd9d6ddc54'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ghostscript'
  depends_on 'glib_networking'
  depends_on 'pango'
  depends_on 'libexif'
  depends_on 'libgudev'
  depends_on 'libheif'
  depends_on 'libmng'
  depends_on 'libtiff'
  depends_on 'libwmf'
  depends_on 'llvm'
  depends_on 'aalib'
  depends_on 'mypaint_brushes'
  depends_on 'openexr'
  depends_on 'poppler_data'
  depends_on 'pygtk'
  depends_on 'shared_mime_info'
  depends_on 'xdg_base'
  depends_on 'sommelier'
  depends_on 'gegl'
  depends_on 'babl'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
