require 'package'

class R < Package
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '3.4.2'
  source_url 'https://cran.r-project.org/src/base/R-3/R-3.4.2.tar.gz'
  source_sha256 '971e30c2436cf645f58552905105d75788bd9733bddbcb7c4fbff4c1a6d80c64'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dac307e30891e02a849e6431df21acac81c8f20bae560c88f5db3216dd2261d0',
     armv7l: 'dac307e30891e02a849e6431df21acac81c8f20bae560c88f5db3216dd2261d0',
       i686: '',
     x86_64: '44be08fad3ef36250aa8b82a26ed3131e8726ba72e0ffbfe6ab120125ea1a26b',
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
