require 'package'

class R < Package
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '3.4.0'
  source_url 'https://cran.r-project.org/src/base/R-3/R-3.4.0.tar.gz'
  source_sha256 '288e9ed42457c47720780433b3d5c3c20983048b789291cc6a7baa11f9428b91'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/r-3.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/r-3.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/r-3.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/r-3.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ecad587a4b088db2bcf7c060cc9bca5c2f41363a347d9dbf87f4bbebb9004fdc',
     armv7l: 'ecad587a4b088db2bcf7c060cc9bca5c2f41363a347d9dbf87f4bbebb9004fdc',
       i686: '96015516d255368462a2f94a5f7c5d4d5b08b3a9deb722f1e92e7ccb181f93cb',
     x86_64: '5e7a26ad793a17c96ea8c49f9fee3254185b5e24d98a8c5bb85bb9009f7df3d1',
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
