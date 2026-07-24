require 'buildsystems/autotools'

class Gnuplot < Autotools
  description 'Gnuplot is a portable command-line driven graphing utility'
  homepage 'https://gnuplot.sourceforge.net/'
  version '6.0.4'
  license 'gnuplot'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/gnuplot/gnuplot/#{version}/gnuplot-#{version}.tar.gz"
  source_sha256 '458d94769625e73d5f6232500f49cbadcb2b183380d43d2266a0f9701aeb9c5b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f4b84cbe20ce05479aff6dfaa379dcd91b94cfcb3e8d1e91b487e5b7c0442524',
     armv7l: 'f4b84cbe20ce05479aff6dfaa379dcd91b94cfcb3e8d1e91b487e5b7c0442524',
     x86_64: '50847494327b062b007791a6cde667facf0b7617f39260f840c5fa2c07e76d68'
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
  depends_on 'qt5_tools' => :library
  depends_on 'readline' => :executable
  depends_on 'wxwidgets' => :executable
  depends_on 'zlib' => :library

  autotools_configure_options "CPPFLAGS='-I#{CREW_PREFIX}/share/Qt-5/include/QtCore \
    -I#{CREW_LIB_PREFIX}/wx/include/gtk3-unicode-3.3'"
end
