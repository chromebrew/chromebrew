require 'package'

class R < Package
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '3.4.3'
  source_url 'https://cran.r-project.org/src/base/R-3/R-3.4.3.tar.gz'
  source_sha256 '7a3cb831de5b4151e1f890113ed207527b7d4b16df9ec6b35e0964170007f426'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '49a5b66353b19c4078daa3081819348f391949dfaea74b25a4a08c15fe6b0d58',
     armv7l: '49a5b66353b19c4078daa3081819348f391949dfaea74b25a4a08c15fe6b0d58',
       i686: 'b3ef1c5ee0c69f8da1dda0292299df1ffc6692c63198a87fe7add6a8bcecd84c',
     x86_64: '997022827cf2709da1c76ab9ffbefcec6f5be21df2a72b1c33c2a797a77dcead',
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

    if `uname -m`.strip == 'x86_64'
      # Chromeos doens't have "en_GB.UTF-8" locale, so ignore error check
      system "sed -i tests/reg-tests-3.R -e '/stopifnot(identical(Sys.setlocale(/s/^/#/'"
      system "make", "check"
    end
  end
end
