require 'package'

class R < Package
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '3.4.1'
  source_url 'https://cran.r-project.org/src/base/R-3/R-3.4.1.tar.gz'
  source_sha256 '02b1135d15ea969a3582caeb95594a05e830a6debcdb5b85ed2d5836a6a3fc78'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ef44637106ac4ee2660578f8e8c5a0e148654126ee875c955604c9a6fd1c5c35',
     armv7l: 'ef44637106ac4ee2660578f8e8c5a0e148654126ee875c955604c9a6fd1c5c35',
       i686: 'b806e5dfea4e46260134830c3fc6667c01031434482eb2c7bdb883fdc51e17aa',
     x86_64: '7fb1a4f3ea5e8237d899b0ea4fe359fdd308799fd4fe05e335e2d804c11783b6',
  })

  # depends_on 'gfortran'       # require gfortran enabled gcc
  depends_on 'pcre'             # need to use pcre not pcre2
  depends_on 'zlibpkg'
  depends_on 'xzutils'

  depends_on 'bz2'
  depends_on 'curl'
  depends_on 'openssl'
  depends_on 'readline'

  def self.build
    system './configure',
      '--with-x=no' # X is not available
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # test fails on armv7l, but passes on x86_64

    if `uname -m`.strip == 'x86_64'
      # Chromeos doens't have "en_GB.UTF-8" locale, so ignore error check
      system "sed -i tests/reg-tests-3.R -e '/stopifnot(identical(Sys.setlocale(/s/^/#/'"
      system "make", "check"
    end
  end
end
