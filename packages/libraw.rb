require 'package'

class Libraw < Package
  description 'Raw image decoder library'
  homepage 'https://www.libraw.org'
  version '0.19.5'
  compatibility 'all'
  source_url 'https://www.libraw.org/data/LibRaw-0.19.5.tar.gz'
  source_sha256 '40a262d7cc71702711a0faec106118ee004f86c86cc228281d12d16da03e02f5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libraw-0.19.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libraw-0.19.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libraw-0.19.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libraw-0.19.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4b5b8a0de463b978d31665cec3651408b2e7d5dde525bf6c81eda6fa50642fc7',
     armv7l: '4b5b8a0de463b978d31665cec3651408b2e7d5dde525bf6c81eda6fa50642fc7',
       i686: '433dff0a0925138fa2b95c842e3e629203605d37a7ea775fc3ba3af459cfee39',
     x86_64: 'b527d25dda9ef11332978032baf05ea14e7c302e03dd68fa03385fac24ba7e95',
  })

  depends_on 'jasper'
  depends_on 'lcms'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
