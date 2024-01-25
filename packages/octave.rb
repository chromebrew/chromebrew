require 'buildsystems/autotools'

class Octave < Autotools
  description 'Scientific Programming Language'
  homepage 'https://octave.org/'
  version '8.4.0'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ftpmirror.gnu.org/octave/octave-8.4.0.tar.lz'
  source_sha256 'd5a7e89928528dce8cab7eead700be8a8319a98ec5334cc2ce83d29ac60264c1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c537235f83bd16c7179fa0f9d7375f9b55c7598582965b2a096c4862bc5ba11e',
     armv7l: 'c537235f83bd16c7179fa0f9d7375f9b55c7598582965b2a096c4862bc5ba11e',
     x86_64: '4d9c32256fe81086821e339011fa30dd6280664a26126b950052e5d6d672421f'
  })

  depends_on 'bzip2' # R
  depends_on 'curl' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gnuplot' => :build
  depends_on 'gperf' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icoutils' => :build
  depends_on 'lapack' => :build
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'librsvg' => :build
  depends_on 'libx11' # R
  depends_on 'openblas' => :build
  depends_on 'pcre2' # R
  depends_on 'readline' # R
  depends_on 'zlibpkg' # R
  depends_on 'openblas' # R
end
