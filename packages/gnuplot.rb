require 'buildsystems/autotools'

class Gnuplot < Autotools
  description 'Gnuplot is a portable command-line driven graphing utility'
  homepage 'https://gnuplot.sourceforge.net/'
  version '6.0.6'
  license 'gnuplot'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/gnuplot/gnuplot/#{version}/gnuplot-#{version}.tar.gz"
  source_sha256 '9d39d8499c9533550144092375aac45ba8bf0c18c9cee50897fe411b6d93004e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3294e54efe8d86ffba94ae0241668a55194fece0790077b92c1ace3fef832150',
     armv7l: '3294e54efe8d86ffba94ae0241668a55194fece0790077b92c1ace3fef832150',
     x86_64: '95adc3483941f65fe68bf04e8f686fb575859cca0172d4294ebd539bc0599a96'
  })

  depends_on 'at_spi2_core' => :executable
  depends_on 'cairo' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'libcerf' => :executable
  depends_on 'libgd' => :executable
  depends_on 'libwebp' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxrender' => :build
  depends_on 'libxxf86vm' => :build
  depends_on 'lua' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'pango' => :executable
  depends_on 'qt5_base' => :executable
  depends_on 'qt5_svg' => :executable
  depends_on 'qt5_tools' => :executable
  depends_on 'readline' => :executable
  depends_on 'wxwidgets' => :executable
  depends_on 'zlib' => :executable

  autotools_configure_options "CPPFLAGS='-I#{CREW_PREFIX}/share/Qt-5/include/QtCore \
    -I#{CREW_LIB_PREFIX}/wx/include/gtk3-unicode-3.3'"
end
