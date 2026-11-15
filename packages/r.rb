require 'buildsystems/autotools'

class R < Autotools
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version "4.6.2-#{CREW_ICU_VER}"
  license 'GPL-2 or GPL-3 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://cran.r-project.org/src/base/R-4/R-#{version.split('-')[0]}.tar.xz"
  source_sha256 '558d569edc9eeb96a104347495200c544df5fab3679c1410e4ad358044829644'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d757968015c5398c86dd15d5e4dc195399ef0b38664ef0d61b5a9313b0960fa',
     armv7l: '8d757968015c5398c86dd15d5e4dc195399ef0b38664ef0d61b5a9313b0960fa',
     x86_64: '819a51d336f5e674451597a8f308d3a0552a4e2b77b49273e49a220da5fec983'
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
