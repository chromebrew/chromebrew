require 'buildsystems/autotools'

class Octave < Autotools
  description 'Scientific Programming Language'
  homepage 'https://octave.org/'
  version '9.2.0'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ftpmirror.gnu.org/octave/octave-9.2.0.tar.lz'
  source_sha256 'dcb2c098701cfcbc083f07e90e146261d15cdbf5e89c031032422112c89b47da'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c544c6fbeb744a4b18400647d1401374a5e01ae290928034e67dc393765e146',
     armv7l: '9c544c6fbeb744a4b18400647d1401374a5e01ae290928034e67dc393765e146',
     x86_64: '6e07dadd875a06bbea3fd0360d8795af8286bd60379d9c12cadeec8b2cc626af'
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
