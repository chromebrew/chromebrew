require 'package'

class R < Package
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '4.0.3'
  compatibility 'all'
  source_url 'https://cran.r-project.org/src/base/R-4/R-4.0.3.tar.gz'
  source_sha256 '09983a8a78d5fb6bc45d27b1c55f9ba5265f78fa54a55c13ae691f87c5bb9e0d'



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
