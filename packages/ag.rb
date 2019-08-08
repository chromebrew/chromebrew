require 'package'

class Ag < Package
  description 'The Silver Searcher. Very fast search similar to ack or grep. (ag)'
  homepage 'https://github.com/ggreer/the_silver_searcher'
  version '2.2.0'
  source_url 'https://github.com/ggreer/the_silver_searcher/archive/2.2.0.tar.gz'
  source_sha256 '6a0a19ca5e73b2bef9481c29a508d2413ca1a0a9a5a6b1bd9bbd695a7626cbf9'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkgconfig" => :build
  depends_on "pcre"
  depends_on "xzutils"
  depends_on "zlibpkg"

  def self.build
    system "autoreconf", "-fiv"
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end

end
