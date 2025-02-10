require 'buildsystems/autotools'

class Octave < Autotools
  description 'Scientific Programming Language'
  homepage 'https://octave.org/'
  version '9.4.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://ftpmirror.gnu.org/octave/octave-#{version}.tar.lz"
  source_sha256 'dcb2c098701cfcbc083f07e90e146261d15cdbf5e89c031032422112c89b47da'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd9708082a6f4c3052e073bf9642c2b54d2e0bcc95aa305d6bc99676894b2e3a',
     armv7l: 'bd9708082a6f4c3052e073bf9642c2b54d2e0bcc95aa305d6bc99676894b2e3a',
     x86_64: '393c3e8cf5f81936be330275e7d4439fbd2da85bca44b3a69ec407a8273d106a'
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
  depends_on 'libsndfile' # R
  depends_on 'libx11' # R
  depends_on 'openblas' # R
  depends_on 'pcre2' # R
  depends_on 'readline' # R
  depends_on 'zlib' # R

  run_tests
end
