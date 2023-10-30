require 'buildsystems/autotools'

class Octave < Autotools
  description 'Scientific Programming Language'
  homepage 'https://octave.org/'
  version '8.2.0'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ftpmirror.gnu.org/octave/octave-8.2.0.tar.lz'
  source_sha256 '8ac875a9f8e44b8eb4b75ca8638531e2ca47cd9d13a6ca39d3a0eccd175f8a05'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/octave/8.2.0_armv7l/octave-8.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/octave/8.2.0_armv7l/octave-8.2.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/octave/8.2.0_x86_64/octave-8.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0b246e0e32f70dc7736b0626a09f770795351ebcc5088a6b8826c61c8c95b3e9',
     armv7l: '0b246e0e32f70dc7736b0626a09f770795351ebcc5088a6b8826c61c8c95b3e9',
     x86_64: '7eeb3d979f6cf071419b4d5d981425bc284db80604d211897950a70934e9832f'
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
