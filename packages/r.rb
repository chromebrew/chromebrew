require 'package'

class R < Package
  version '3.3.2'
  source_url 'https://cran.rstudio.com/src/base/R-3/R-3.3.2.tar.gz'
  source_sha1 '0e39e9c2d28fe6bab9c55ca23e08ba8727fd2fca'

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
end
