require 'buildsystems/autotools'

class Gnuplot < Autotools
  description 'Gnuplot is a portable command-line driven graphing utility'
  homepage 'https://gnuplot.sourceforge.net/'
  version '6.0.5'
  license 'gnuplot'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/gnuplot/gnuplot/#{version}/gnuplot-#{version}.tar.gz"
  source_sha256 '73237f37f03306d68bfae133a9a50d5e9341384e198d5ab37eeca9ab534deed8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7f5bc1a18a88a8b46987e949c21698e436d45dcbb6735a1b2039b230c5363a57',
     armv7l: '7f5bc1a18a88a8b46987e949c21698e436d45dcbb6735a1b2039b230c5363a57',
     x86_64: '04e85c41cd1dc2b5d94213e7035453b201977893d656a1db4f1efab3bca01efc'
  })

  depends_on 'at_spi2_core' => :executable
  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :executable
  depends_on 'harfbuzz' => :library
  depends_on 'libcerf' => :library
  depends_on 'libgd' => :executable
  depends_on 'libwebp' => :executable
  depends_on 'libx11' => :library
  depends_on 'libxrender' => :library
  depends_on 'libxxf86vm' => :library
  depends_on 'lua' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'pango' => :library
  depends_on 'qt5_base' => :library
  depends_on 'qt5_svg' => :library
  depends_on 'qt5_tools' => :executable
  depends_on 'readline' => :executable
  depends_on 'wxwidgets' => :executable
  depends_on 'zlib' => :library

  autotools_configure_options "CPPFLAGS='-I#{CREW_PREFIX}/share/Qt-5/include/QtCore \
    -I#{CREW_LIB_PREFIX}/wx/include/gtk3-unicode-3.3'"
end
