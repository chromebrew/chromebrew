require 'package'

class Gimp < Package
  description 'GIMP is a cross-platform image editor available for GNU/Linux, OS X, Windows and more operating systems.'
  homepage 'https://www.gimp.org/'
  version '2.10.18'
  source_url 'https://download.gimp.org/pub/gimp/v2.10/gimp-2.10.18.tar.bz2'
  source_sha256 '65bfe111e8eebffd3dde3016ccb507f9948d2663d9497cb438d9bb609e11d716'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'aalib'
  depends_on 'babl'
  depends_on 'ffmpeg'
  depends_on 'gegl'
  depends_on 'ghostscript'
  depends_on 'glib_networking'
  depends_on 'libexif'
  depends_on 'libgudev'
  depends_on 'libheif'
  depends_on 'libmng'
  depends_on 'libtiff'
  depends_on 'libwmf'
  depends_on 'llvm'
  depends_on 'mypaint_brushes'
  depends_on 'openexr'
  depends_on 'poppler_data'
  depends_on 'pygtk'
  depends_on 'shared_mime_info'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.build
    system "LIBS='-lm' ./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
