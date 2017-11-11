require 'package'

class Aprutil < Package
  description 'APR-util provides a number of helpful abstractions on top of APR.'
  homepage 'http://apr.apache.org/'
  version '1.6.1'
  source_url 'https://apache.claz.org/apr/apr-util-1.6.1.tar.bz2'
  source_sha256 'd3e12f7b6ad12687572a3a39475545a072608f4ba03a6ce8a3778f607dd0035b'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'apr'
  depends_on 'expat'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-apr=#{CREW_PREFIX}",
           '--disable-maintainer-mode'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
