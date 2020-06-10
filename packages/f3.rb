require 'package'

class F3 < Package
  description 'F3 is a simple tool that tests flash cards\' capacity and performance to see if they live up to claimed specifications.'
  homepage 'http://oss.digirati.com.br/f3/'
  version '7.1'
  compatibility 'all'
  source_url 'https://github.com/AltraMayor/f3/archive/v7.1.tar.gz'
  source_sha256 '1d9edf12d3f40c03a552dfc3ed36371c62933b9213483182f7a561e1a5b8e1cc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/f3-7.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/f3-7.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/f3-7.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/f3-7.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0e024b920108a42f8c5497a045972998fd2768c3f6103c05a14785583429298f',
     armv7l: '0e024b920108a42f8c5497a045972998fd2768c3f6103c05a14785583429298f',
       i686: '16952ecc8722d1e56f1f0abd2f1c544b0f4c9d4abd33b3e5bb9c3d8a8da3773d',
     x86_64: '71bd956a914f6021cedb66723f44fa145f5d3d928353fd2465316351c3b26421',
  })

  depends_on 'parted'
  depends_on 'eudev'

  def self.build
    system 'make'
    system 'make', 'extra'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-extra"
  end
end
