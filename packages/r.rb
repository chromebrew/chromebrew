require 'package'

class R < Package
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '4.0.3'
  compatibility 'all'
  source_url 'https://cran.r-project.org/src/base/R-4/R-4.0.3.tar.gz'
  source_sha256 '09983a8a78d5fb6bc45d27b1c55f9ba5265f78fa54a55c13ae691f87c5bb9e0d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/r-4.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/r-4.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/r-4.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/r-4.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a02c0c2dbc2550b88ca84a733340f1059dc3b419c79628181a51855209340063',
     armv7l: 'a02c0c2dbc2550b88ca84a733340f1059dc3b419c79628181a51855209340063',
       i686: 'c6ed99b4cafa87e7cf02b39f8433ce556a88c99dc6065cc46e9f3273f15f07d7',
     x86_64: '925dfcc3add3c3039ff56135d483417581a7ba04449c1aff7d10149e2f5fad36',
  })



  # depends_on 'gfortran'       # require gfortran enabled gcc
  depends_on 'pcre2'            
  depends_on 'libjpeg'
  depends_on 'libtiff'
  depends_on 'xzutils'
  depends_on 'bz2'
  depends_on 'curl'
  depends_on 'tk'
  depends_on 'xdg_utils'
  depends_on 'sommelier'
  depends_on 'libiconv' => ':build' #if iconv error then reinstall libiconv

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
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # tests fail.
    #if ARCH == 'x86_64'
      # Chromeos doesn't have "en_GB.UTF-8" locale, so ignore error check
      #system "sed -i tests/reg-tests-3.R -e '/stopifnot(identical(Sys.setlocale(/s/^/#/'"
      #system 'make', 'check'
    #end
  end
end
