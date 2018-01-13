require 'package'

class R < Package
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '3.4.3-1'
  source_url 'https://cran.r-project.org/src/base/R-3/R-3.4.3.tar.gz'
  source_sha256 '7a3cb831de5b4151e1f890113ed207527b7d4b16df9ec6b35e0964170007f426'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cfbe1876271be723e1477c325830917fa45acb5e36187bbcb3d8ce835668357e',
     armv7l: 'cfbe1876271be723e1477c325830917fa45acb5e36187bbcb3d8ce835668357e',
       i686: '7d69683c6b3c9ce41718652eccc1b4ddb4cba42fee7060c00a06d3afdf25ebca',
     x86_64: 'b70dbd51af3b9c1676bc4e9c3d90ff4169556a6937f81a51252c7be81b365f05',
  })

  # depends_on 'gfortran'       # require gfortran enabled gcc
  depends_on 'pcre'             # need to use pcre not pcre2
  depends_on 'zlibpkg'
  depends_on 'xzutils'
  depends_on 'bz2'
  depends_on 'curl'
  depends_on 'openssl'
  depends_on 'readline'
  depends_on 'icu4c'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--with-x=no' # X is not available
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
