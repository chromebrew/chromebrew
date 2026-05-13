require 'buildsystems/autotools'

class R < Autotools
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version "4.6.0-#{CREW_ICU_VER}"
  license 'GPL-2 or GPL-3 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://cran.r-project.org/src/base/R-4/R-#{version.split('-')[0]}.tar.xz"
  source_sha256 '91f2b3693fa5252cdea9b62abc84a1c58db5547cb9f0fe3d15f44eef8aff5a27'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6e3c8227268d71e18395f38e0f579df6b79e06ef27ed917defd4c640628078cd',
     armv7l: '6e3c8227268d71e18395f38e0f579df6b79e06ef27ed917defd4c640628078cd',
     x86_64: '09effba770bc821d6259fbd6f13e5155bea4de368efb0640104e7dafe6c35751'
  })

  depends_on 'bzip2' => :library
  depends_on 'cairo' => :library
  depends_on 'curl' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'icu4c' => :library
  depends_on 'lapack' => :library
  depends_on 'libdeflate' => :library
  depends_on 'libice' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libsm' => :library
  depends_on 'libtiff' => :library
  depends_on 'libtirpc' => :library
  depends_on 'libx11' => :library
  depends_on 'libxext' => :library
  depends_on 'libxmu' => :library
  depends_on 'libxss' => :library
  depends_on 'libxt' => :library
  depends_on 'pango' => :library
  depends_on 'pcre2' => :library
  depends_on 'readline' => :library
  depends_on 'tcl' => :library
  depends_on 'tk' => :library
  depends_on 'xdg_utils' => :build
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  autotools_configure_options '--enable-R-shlib \
           --with-x'

  run_tests
end
