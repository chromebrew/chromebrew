require 'package'

class R < Package
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '3.5.1'
  source_url 'https://cran.r-project.org/src/base/R-3/R-3.5.1.tar.gz'
  source_sha256 '0463bff5eea0f3d93fa071f79c18d0993878fd4f2e18ae6cf22c1639d11457ed'

  binary_url ({
  })
  binary_sha256 ({
  })

  # depends_on 'gfortran'       # require gfortran enabled gcc
  depends_on 'pcre'             # need to use pcre not pcre2
  depends_on 'zlibpkg'
  depends_on 'xzutils'
  depends_on 'bz2'
  depends_on 'curl'
  depends_on 'openssl'
  depends_on 'readline7'
  depends_on 'icu4c'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--with-x=no', # X is not available
	  '--enable-R-shlib'
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
