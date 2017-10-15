require 'package'

class Rlwrap < Package
  description 'A readline wrapper'
  homepage 'https://github.com/hanslub42/rlwrap'
  version '0.43'
  source_url 'https://github.com/hanslub42/rlwrap/archive/v0.43.tar.gz'
  source_sha256 '29e5a850fbe4753f353b0734e46ec0da043621bdcf7b52a89b77517f3941aade'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'autoconf'
  depends_on 'readline'

  def self.build
    system "autoreconf --install"
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
