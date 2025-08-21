require 'buildsystems/autotools'

class Gnuplot < Autotools
  description 'Gnuplot is a portable command-line driven graphing utility'
  homepage 'https://gnuplot.sourceforge.net/'
  version '6.0.3'
  license 'gnuplot'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/gnuplot/gnuplot/#{version}/gnuplot-#{version}.tar.gz"
  source_sha256 'ec52e3af8c4083d4538152b3f13db47f6d29929a3f6ecec5365c834e77f251ab'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c942209f80d406f73ed343cabcaf11e05017c9dfeef7655bde3c47574b882c29',
     armv7l: 'c942209f80d406f73ed343cabcaf11e05017c9dfeef7655bde3c47574b882c29',
     x86_64: 'a3a87f4195008a31f6d11bde6c19a22594673b7c7a25a6a2fa628a1ba284c7f7'
  })

  depends_on 'cairo'
  depends_on 'libcerf'
  depends_on 'libgd'
  depends_on 'libwebp'
  depends_on 'libxrender'
  depends_on 'libxxf86vm'
  depends_on 'lua'
  depends_on 'pango'
  depends_on 'qt5_base'
  depends_on 'qt5_svg'
  depends_on 'qt5_tools'
  depends_on 'wxwidgets'

  autotools_configure_options "CFLAGS='-I#{CREW_PREFIX}/share/Qt-5/include/QtCore'"
end
