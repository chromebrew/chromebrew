require 'package'

class Libraw < Package
  description 'Raw image decoder library'
  homepage 'https://www.libraw.org'
  version '0.19.5'
  compatibility 'all'
  source_url 'https://www.libraw.org/data/LibRaw-0.19.5.tar.gz'
  source_sha256 '40a262d7cc71702711a0faec106118ee004f86c86cc228281d12d16da03e02f5'

  depends_on 'jasper'
  depends_on 'lcms'

  def self.build
      system "./configure #{CREW_OPTIONS} "
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
