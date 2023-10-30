require 'package'

class R < Package
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '4.2.3'
  license 'GPL-2 or GPL-3 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://cran.r-project.org/src/base/R-4/R-4.2.3.tar.gz'
  source_sha256 '55e4a9a6d43be314e2c03d0266a6fa5444afdce50b303bfc3b82b3979516e074'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/r/4.2.3_armv7l/r-4.2.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/r/4.2.3_armv7l/r-4.2.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/r/4.2.3_i686/r-4.2.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/r/4.2.3_x86_64/r-4.2.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f711a539777bb37da48892cf2742ae4541cc985e0e5d690e4a10c4b09cfbcc98',
     armv7l: 'f711a539777bb37da48892cf2742ae4541cc985e0e5d690e4a10c4b09cfbcc98',
       i686: 'b69271b2fe3b38f37315b685eeb023a4a6ce6f1e6cc48b762fa4cb6725cc47aa',
     x86_64: '2a5cfece8a24b8bad17ade73b2751cf23c1c9d5e1604addce436e45740400354'
  })

  depends_on 'bzip2' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'icu4c' # R
  depends_on 'curl' => :build
  depends_on 'libice' # R
  depends_on 'libjpeg' # R
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

  def self.build
    @x = ARCH == 'i686' ? '' : '--with-x'
    system "./configure #{CREW_OPTIONS} \
           --disable-maintainer-mode \
           --enable-R-shlib \
           #{@x}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # tests fail.
    # if ARCH == 'x86_64'
    # Chromeos doesn't have "en_GB.UTF-8" locale, so ignore error check
    # system "sed -i tests/reg-tests-3.R -e '/stopifnot(identical(Sys.setlocale(/s/^/#/'"
    # system 'make', 'check'
    # end
  end
end
