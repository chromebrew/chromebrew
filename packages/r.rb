require 'buildsystems/autotools'

class R < Autotools
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '4.3.2'
  license 'GPL-2 or GPL-3 and LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://cran.r-project.org/src/base/R-4/R-4.3.2.tar.gz'
  source_sha256 'b3f5760ac2eee8026a3f0eefcb25b47723d978038eee8e844762094c860c452a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd6907d92580d0ca488c5dcfc7c274b09aed94d3fd1ff500442f7101616c1cf6d',
     armv7l: 'd6907d92580d0ca488c5dcfc7c274b09aed94d3fd1ff500442f7101616c1cf6d',
     x86_64: 'def76c5bcfd0f929fe5579e4de4850276c4c359fb1b4e6a1375de63717d5a9a2'
  })

  depends_on 'bzip2' # R
  depends_on 'curl' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'icu4c' # R
  depends_on 'lapack' # R
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
  depends_on 'zlibpkg' # R

  configure_options '--enable-R-shlib \
           --with-x'
end
