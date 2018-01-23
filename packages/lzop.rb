require 'package'

class Lzop < Package
  description 'lzop is a file compressor which is very similar to gzip.'
  homepage 'http://www.lzop.org/'
  version '1.04'
  source_url 'https://www.lzop.org/download/lzop-1.04.tar.gz'
  source_sha256 '7e72b62a8a60aff5200a047eea0773a8fb205caf7acbe1774d95147f305a2f41'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lzop-1.04-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lzop-1.04-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lzop-1.04-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lzop-1.04-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b7cd8133920f0a9db798bd871cd9e7779f7b6fe7c587fb55c05b8b72d32e123a',
     armv7l: 'b7cd8133920f0a9db798bd871cd9e7779f7b6fe7c587fb55c05b8b72d32e123a',
       i686: '4c5e9ee6dbb95950c5b30c49705e33891c768c085cccb7dbef9d0e7757ecd20d',
     x86_64: 'd51dfeaafb14d3e4927957627c4c19f5fca9c8aa0a2b5c977045eeb1caac9728',
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
