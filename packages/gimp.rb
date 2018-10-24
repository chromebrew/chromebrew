require 'package'

class Gimp < Package
  description 'GIMP is a cross-platform image editor available for GNU/Linux, OS X, Windows and more operating systems.'
  homepage 'https://www.gimp.org/'
  version '2.10.6'
  source_url 'https://download.gimp.org/pub/gimp/v2.10/gimp-2.10.6.tar.bz2'
  source_sha256 '4ec8071f828e918384cf7bc7d1219210467c84655123f802bc55a8bf2415101f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gimp-2.10.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gimp-2.10.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gimp-2.10.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gimp-2.10.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f237f502445c1dbd8aa88c1e5bb2bd74efaf53bb20712edce62f30436b24253d',
     armv7l: 'f237f502445c1dbd8aa88c1e5bb2bd74efaf53bb20712edce62f30436b24253d',
       i686: '7edecd8e91873795fc234d2000f2ac03392f5ce6947492d36bc9df582d7dd015',
     x86_64: '8d2400b5806a22e5afc39b1ec1571a7fdba416dded25a77baa7192c32e0c2c64',
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
