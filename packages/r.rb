require 'buildsystems/autotools'

class R < Autotools
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version "4.5.3-#{CREW_ICU_VER}"
  license 'GPL-2 or GPL-3 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://cran.r-project.org/src/base/R-4/R-#{version.split('-')[0]}.tar.xz"
  source_sha256 'c9a6555bb94c104b9c02905360c57de0dcac5dd31923dc5bb6ef3af7744615f1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '932ab1a7e6c328c49e1d6976f52820062a5f197ad26db6403f7353f234e39e5d',
     armv7l: '932ab1a7e6c328c49e1d6976f52820062a5f197ad26db6403f7353f234e39e5d',
     x86_64: '21fe2797731ed3ce5804e15020a7b5d6a89d6045f516b94b27ee4c49dc9a37d0'
  })

  depends_on 'bzip2' => :library
  depends_on 'curl' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'icu4c' => :library
  depends_on 'lapack' => :library
  depends_on 'libdeflate' => :library
  depends_on 'libice' => :library
  depends_on 'libpng' => :library
  depends_on 'libsm' => :library
  depends_on 'libtiff' => :library
  depends_on 'libx11' => :library
  depends_on 'libxext' => :library
  depends_on 'libxmu' => :library
  depends_on 'libxss' => :library
  depends_on 'libxt' => :library
  depends_on 'pango' => :library
  depends_on 'pcre2' => :build
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
