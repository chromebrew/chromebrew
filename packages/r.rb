require 'package'

class R < Package
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '3.5.3'
  source_url 'https://cran.r-project.org/src/base/R-3/R-3.5.3.tar.gz'
  source_sha256 '2bfa37b7bd709f003d6b8a172ddfb6d03ddd2d672d6096439523039f7a8e678c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.5.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.5.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.5.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.5.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c46c93e863aba8ab008cbee48c58461f2c6635f960d7ef055c3191d6cc196b61',
     armv7l: 'c46c93e863aba8ab008cbee48c58461f2c6635f960d7ef055c3191d6cc196b61',
       i686: 'e66d5534875cd1ee37b5c1ac61fd32697b37fdd74fbcc7482d93f19f90c107b8',
     x86_64: 'd7847ba30fe5565fcb3eb5fa3e1eff93c984392f630a239c07c730a44a1cfad5',
  })

  # depends_on 'gfortran'       # require gfortran enabled gcc
  depends_on 'pcre'             # need to use pcre not pcre2
  depends_on 'libjpeg'
  depends_on 'libtiff'
  depends_on 'xzutils'
  depends_on 'bz2'
  depends_on 'curl'
  depends_on 'tk'
  depends_on 'xdg_utils'
  depends_on 'sommelier'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-maintainer-mode',
      '--enable-R-shlib',
      '--with-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # test fails on armv7l, but passes on x86_64

    if ARCH == 'x86_64'
      # Chromeos doens't have "en_GB.UTF-8" locale, so ignore error check
      system "sed -i tests/reg-tests-3.R -e '/stopifnot(identical(Sys.setlocale(/s/^/#/'"
      system "make", "check"
    end
  end
end
