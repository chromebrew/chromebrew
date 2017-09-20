require 'package'

class Ag < Package
  description 'The Silver Searcher. Very fast search similar to ack or grep. (ag)'
  homepage 'https://github.com/ggreer/the_silver_searcher'
  version '2.1.0-1'
  source_url 'https://github.com/ggreer/the_silver_searcher/archive/2.1.0.tar.gz'
  source_sha256 'cb416a0da7fe354a009c482ae709692ed567f8e7d2dad4d242e726dd7ca202f0'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on "autoconf"
  depends_on "automake"
  depends_on "pkgconfig"
  depends_on "pcre"
  depends_on "xzutils"

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
