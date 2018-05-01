require 'package'

class Inkscape < Package
  description 'Inkscape is a professional vector graphics editor for Windows, Mac OS X and Linux.'
  homepage 'https://inkscape.org'
  version '0.92.3'
  source_url 'https://inkscape.org/de/gallery/item/12187/inkscape-0.92.3.tar.bz2'
  source_sha256 '063296c05a65d7a92a0f627485b66221487acfc64a24f712eb5237c4bd7816b2'

  depends_on 'boost'
  depends_on 'gtkmm3'
  depends_on 'gnome_docking_library'
  depends_on 'libxslt'
  depends_on 'poppler'  # 0.63.0
  depends_on 'lcms'
  depends_on 'imagemagick6'
  depends_on 'gsl'
  depends_on 'bdwgc'

  def self.build
    system "mkdir -p builddir"
    Dir.chdir("builddir") do
      system "cmake",
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX}",
             "-DCMAKE_BUILD_TYPE=Release",
             ".."
      system "make"
    end
  end

  def self.install                 # the steps required to install the package
    Dir.chdir("builddir") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
