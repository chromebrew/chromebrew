require 'package'

class Inkscape < Package
  description 'Inkscape is a professional vector graphics editor for Windows, Mac OS X and Linux.'
  homepage 'https://inkscape.org/'
  version '0.92.3'
  compatibility 'all'
  source_url 'https://inkscape.org/gallery/item/12187/inkscape-0.92.3.tar.bz2'
  source_sha256 '063296c05a65d7a92a0f627485b66221487acfc64a24f712eb5237c4bd7816b2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/inkscape-0.92.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/inkscape-0.92.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/inkscape-0.92.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/inkscape-0.92.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '99b2d2527b668282d0107327b76dc2f44f5f0cee3b5cc2a4e8259d8d3aae5676',
     armv7l: '99b2d2527b668282d0107327b76dc2f44f5f0cee3b5cc2a4e8259d8d3aae5676',
       i686: 'c070cbd4692cea127b45360c7a935ee7e926204cf3fa6eb457d418a80092ae03',
     x86_64: '82456ad92d50e2167e8e79f8072d1a13fcaf51d8837ab6bec942034ae80ba09d',
  })

  depends_on 'bdwgc'
  depends_on 'boost'
  depends_on 'gsl'
  depends_on 'gtkmm2'
  depends_on 'hicolor_icon_theme'
  depends_on 'imagemagick6'
  depends_on 'imagemagick7'
  depends_on 'llvm'
  depends_on 'popt'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.build
    system './autogen.sh'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
