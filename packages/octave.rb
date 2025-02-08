require 'buildsystems/autotools'

class Octave < Autotools
  description 'Scientific Programming Language'
  homepage 'https://octave.org/'
  version '9.4.0'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://ftpmirror.gnu.org/octave/octave-#{version}.tar.lz"
  source_sha256 'dcb2c098701cfcbc083f07e90e146261d15cdbf5e89c031032422112c89b47da'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1f1f064e4687c6e763d459aa413aa1af7d9dae1b40a900d68bee6d2279c080bc',
     armv7l: '1f1f064e4687c6e763d459aa413aa1af7d9dae1b40a900d68bee6d2279c080bc',
     x86_64: 'a8563280d303c5f643f89af2c919f484208b537d0ea42fd7260bfe742db0c655'
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
  depends_on 'zlib' # R
  depends_on 'openblas' # R

  run_tests
end
