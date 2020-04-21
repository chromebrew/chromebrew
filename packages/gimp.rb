require 'package'

class Gimp < Package
  description 'GIMP is a cross-platform image editor available for GNU/Linux, OS X, Windows and more operating systems.'
  homepage 'https://www.gimp.org/'
  version '2.10.18'
  source_url 'https://download.gimp.org/pub/gimp/v2.10/gimp-2.10.18.tar.bz2'
  source_sha256 '65bfe111e8eebffd3dde3016ccb507f9948d2663d9497cb438d9bb609e11d716'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gimp-2.10.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gimp-2.10.18-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gimp-2.10.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '079527b6bb35dbbb7a5b70a8aaae03bb9e90341d1f638e82114c254a35074c9e',
     armv7l: '079527b6bb35dbbb7a5b70a8aaae03bb9e90341d1f638e82114c254a35074c9e',
     x86_64: '976807fa73b0f6f3c69750aab669e4ab095f237cdc3970b63e1df50b98f2d619',
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
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
    system "LIBS='-lm' ./configure #{CREW_OPTIONS} --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
