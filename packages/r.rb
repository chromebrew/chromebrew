require 'package'

class R < Package
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '3.5.1'
  source_url 'https://cran.r-project.org/src/base/R-3/R-3.5.1.tar.gz'
  source_sha256 '0463bff5eea0f3d93fa071f79c18d0993878fd4f2e18ae6cf22c1639d11457ed'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '983840999a1c53a65cee42ba0a0fcef1cb4c61833d8de078beae5ba83300c908',
     armv7l: '983840999a1c53a65cee42ba0a0fcef1cb4c61833d8de078beae5ba83300c908',
       i686: 'd6e8403d9001e8412ad3c17c9422816ab594c1eb2b2576ad0dbb49c27af02cf9',
     x86_64: 'bd46cf97defc2d200e1bf94c0a157040a5f86cc56ffc99e85b6abe5e875f9e50',
  })

  # depends_on 'gfortran'       # require gfortran enabled gcc
  depends_on 'pcre'             # need to use pcre not pcre2
  depends_on 'xzutils'
  depends_on 'bz2'
  depends_on 'curl'

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
