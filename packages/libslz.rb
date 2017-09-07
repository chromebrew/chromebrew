require 'package'

class Libslz < Package
  description 'SLZ is a fast and memory-less stream compressor which produces an output that can be decompressed with zlib or gzip.'
  homepage 'http://www.libslz.org/'
  version '1.1.0-1'
  source_url 'http://git.1wt.eu/web?p=libslz.git;a=snapshot;h=afa04ae1f976957cf36287cc5370998d0559bc63;sf=tbz2'
  source_sha256 'cf6b2c00066890d3c7f40ef00e6620784b9dc4662e9a3b35f2059997037be728'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "make PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
