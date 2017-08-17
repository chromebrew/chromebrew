require 'package'

class Ag < Package
  description 'The Silver Searcher. Very fast search similar to ack or grep. (ag)'
  homepage 'https://github.com/ggreer/the_silver_searcher'
  version '2.0.0'
  source_url 'https://github.com/ggreer/the_silver_searcher/archive/2.0.0.tar.gz'
  source_sha256 'ff7243863f22ed73eeab6f7a6d17cfff585a7eaa41d5ab3ae4f5d6db97701d5f'

  depends_on "autoconf"
  depends_on "automake"
  depends_on "pkgconfig"
  depends_on "pcre"
  depends_on "xzutils"

  def self.build
    system "autoreconf", "-fiv"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end

end
