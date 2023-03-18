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
    aarch64: '1d01f36d352e2ea85eecfa30e201c5255a81faf080cea2e02d72932836185053',
     armv7l: '1d01f36d352e2ea85eecfa30e201c5255a81faf080cea2e02d72932836185053',
       i686: '5a8ead751ce5da6966b9b8121585c34a6b89cf1c8af32f24cc890073c8d59d93',
     x86_64: '845b50f2d03d03e57657e0296d3beb69aaa03613c1e36ffa1698f67197121c75'
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
  depends_on 'tcl' # R
  depends_on 'tk' # R
  depends_on 'xdg_utils'
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R

  def self.build
    @x = ARCH == 'i686' ? '--with-x' : ''
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
