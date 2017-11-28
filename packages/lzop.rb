require 'package'

class Lzop < Package
  description 'lzop is a file compressor which is very similar to gzip.'
  homepage 'http://www.lzop.org/'
  version '1.04'
  source_url 'https://www.lzop.org/download/lzop-1.04.tar.gz'
  source_sha256 '7e72b62a8a60aff5200a047eea0773a8fb205caf7acbe1774d95147f305a2f41'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'lzo'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --disable-dependency-tracking \
            --disable-maintainer-mode"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
