require 'package'

class R < Package
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '4.2.1'
  license 'GPL-2 or GPL-3 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://cran.r-project.org/src/base/R-4/R-4.2.1.tar.gz'
  source_sha256 '4d52db486d27848e54613d4ee977ad952ec08ce17807e1b525b10cd4436c643f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/r/4.2.1_armv7l/r-4.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/r/4.2.1_armv7l/r-4.2.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/r/4.2.1_i686/r-4.2.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/r/4.2.1_x86_64/r-4.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0379aede03d7f071eaabca15950fba925766cd9593cdb46c9e051dac042a46a2',
     armv7l: '0379aede03d7f071eaabca15950fba925766cd9593cdb46c9e051dac042a46a2',
       i686: '3ea08d8f5c589d2c38d92a4e02451dce527af8bfaed90a88d8634a18e994cafe',
     x86_64: 'd8cef728a082b5015e374a45fd5ec68253f57f5e7810b72ce2d3387413126997'
  })

  # depends_on 'gfortran'       # require gfortran enabled gcc
  depends_on 'bz2' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'icu4c' # R
  depends_on 'curl'
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
  depends_on 'pcre2'
  depends_on 'sommelier'
  depends_on 'tcl' # R
  depends_on 'tk' # R
  depends_on 'xdg_utils'
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
           --disable-maintainer-mode \
           --enable-R-shlib \
           --with-x"
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
