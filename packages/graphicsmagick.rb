require 'package'

class Graphicsmagick < Package
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version '1.3.35'
  compatibility 'all'
  source_url 'http://ftp.icm.edu.pl/pub/unix/graphics/GraphicsMagick/1.3/GraphicsMagick-1.3.35.tar.gz'
  source_sha256 'd96d5ce2ef7e0e90166551e38742713728bfd33d6f18495a9ddda938700fc055'

  depends_on 'docutils'
  depends_on 'freetype'
  depends_on 'ghostscript'
  depends_on 'libwebp'
  depends_on 'libwmf'
  depends_on 'msttcorefonts'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_PREFIX}/lib64",
           "--mandir=#{CREW_PREFIX}/share/man",
           "--with-windows-font-dir=#{CREW_PREFIX}/share/fonts/truetype/msttcorefonts",
           "--with-perl=#{CREW_PREFIX}/bin/perl",
           '--disable-maintainer-mode',
           '--enable-magick-compat',
           '--enable-shared=yes',
           '--enable-static=no',
           '--with-modules',
           '--with-xml'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
