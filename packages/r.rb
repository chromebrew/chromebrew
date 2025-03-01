require 'buildsystems/autotools'

class R < Autotools
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version "4.4.3-#{CREW_ICU_VER}"
  license 'GPL-2 or GPL-3 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://cran.r-project.org/src/base/R-4/R-#{version.split('-')[0]}.tar.xz"
  source_sha256 'b4cb675deaaeb7299d3b265d218cde43f192951ce5b89b7bb1a5148a36b2d94d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4c5324397f42b424d85ece0fc0ef3aecd0a87c9752038dd2efcafeebcb4a9755',
     armv7l: '4c5324397f42b424d85ece0fc0ef3aecd0a87c9752038dd2efcafeebcb4a9755',
     x86_64: '89d6dce7aca4dd63487618136451dad92a5df3b103b248d21a455298aae07b1b'
  })

  depends_on 'bzip2' # R
  depends_on 'curl' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'icu4c' # R
  depends_on 'lapack' # R
  depends_on 'libdeflate' # R
  depends_on 'libice' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libsm' # R
  depends_on 'libtiff' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxmu' # R
  depends_on 'libxss' # R
  depends_on 'libxt' # R
  depends_on 'pango' # R
  depends_on 'pcre2' => :build
  depends_on 'tcl' # R
  depends_on 'tk' # R
  depends_on 'xdg_utils' => :build
  depends_on 'xzutils' # R
  depends_on 'zlib' # R

  configure_options '--enable-R-shlib \
           --with-x'

  run_tests
end
