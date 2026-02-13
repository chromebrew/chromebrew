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
    aarch64: 'a9d193a5f66e87d418772a22386826a4c7c695c58193fc799a846af90ae41795',
     armv7l: 'a9d193a5f66e87d418772a22386826a4c7c695c58193fc799a846af90ae41795',
     x86_64: '71bb3d83d27298efa8bfe43b333f3b0146632034dbfa037db7cf33b2f9f59509'
  })

  depends_on 'at_spi2_core' => :executable_only
  depends_on 'cairo' => :executable_only
  depends_on 'gcc_lib' => :executable_only
  depends_on 'gdk_pixbuf' => :executable_only
  depends_on 'glib' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'gtk3' => :executable_only
  depends_on 'harfbuzz' => :executable_only
  depends_on 'libcerf' => :executable_only
  depends_on 'libgd' => :executable_only
  depends_on 'libwebp' => :executable_only
  depends_on 'libx11' => :executable_only
  depends_on 'libxrender'
  depends_on 'libxxf86vm'
  depends_on 'lua' => :executable_only
  depends_on 'ncurses' => :executable_only
  depends_on 'pango' => :executable_only
  depends_on 'qt5_base' => :executable_only
  depends_on 'qt5_svg' => :executable_only
  depends_on 'qt5_tools'
  depends_on 'readline' => :executable_only
  depends_on 'wxwidgets' => :executable_only
  depends_on 'zlib' => :executable_only

  autotools_configure_options "CPPFLAGS='-I#{CREW_PREFIX}/share/Qt-5/include/QtCore \
    -I#{CREW_LIB_PREFIX}/wx/include/gtk3-unicode-3.3'"
end
