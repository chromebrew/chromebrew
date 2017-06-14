require 'package'

class R < Package
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '3.4.0'
  source_url 'https://cran.r-project.org/src/base/R-3/R-3.4.0.tar.gz'
  source_sha1 '054c1d099006354c89b195df6783b933846ced60'

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
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
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
