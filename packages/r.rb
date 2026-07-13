require 'buildsystems/autotools'

class R < Autotools
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version "4.6.1-#{CREW_ICU_VER}"
  license 'GPL-2 or GPL-3 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://cran.r-project.org/src/base/R-4/R-#{version.split('-')[0]}.tar.xz"
  source_sha256 'e4149581e151f3f1bc5edd6475e24ca1e2f452c08b6a22c29b570ce8abfe5783'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '906338a18a872a2176977aa868d61b1ca145fb737943b00f094e1fbf529a08ba',
     armv7l: '906338a18a872a2176977aa868d61b1ca145fb737943b00f094e1fbf529a08ba',
     x86_64: '2975f414d160402a8a5cd1183bfbd4c41c3f2aa159e52d2ff6e5fc29f48beaae'
  })

  depends_on 'bzip2' => :library
  depends_on 'cairo' => :library
  depends_on 'curl' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
