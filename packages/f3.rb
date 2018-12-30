require 'package'

class F3 < Package
  description 'F3 is a simple tool that tests flash cards\' capacity and performance to see if they live up to claimed specifications.'
  homepage 'http://oss.digirati.com.br/f3/'
  version '7.1'
  source_url 'https://github.com/AltraMayor/f3/archive/v7.1.tar.gz'
  source_sha256 '1d9edf12d3f40c03a552dfc3ed36371c62933b9213483182f7a561e1a5b8e1cc'

  binary_url ({
  })
  binary_sha256 ({
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
