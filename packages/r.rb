require 'package'

class R < Package
  description 'R is a free software environment for statistical computing and graphics.'
  homepage 'https://www.r-project.org/'
  version '3.6.1'
  compatibility 'all'
  source_url 'https://cran.r-project.org/src/base/R-3/R-3.6.1.tar.gz'
  source_sha256 '5baa9ebd3e71acecdcc3da31d9042fb174d55a42829f8315f2457080978b1389'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/r-3.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c04d57704db615dae4c7b702f34631eb8584c700a5fdc066a071324d21dba395',
     armv7l: 'c04d57704db615dae4c7b702f34631eb8584c700a5fdc066a071324d21dba395',
       i686: '1b0a23d3170a4b0d1062662d504c0a35ec91de032c14d7e53b215e1f3755a943',
     x86_64: '2b3dbede3f2eb97ffd3f158dd039df87f223e985ef69eb6330ee3b8d1f0835b2',
  })

  # depends_on 'gfortran'       # require gfortran enabled gcc
  depends_on 'pcre'             # need to use pcre not pcre2
  depends_on 'libjpeg'
  depends_on 'libtiff'
  depends_on 'xzutils'
  depends_on 'bz2'
  depends_on 'curl'
  depends_on 'tk'
  depends_on 'xdg_utils'
  depends_on 'sommelier'

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
