require 'package'

class Ag < Package
  description 'The Silver Searcher. Very fast search similar to ack or grep. (ag)'
  homepage 'https://github.com/ggreer/the_silver_searcher'
  version '2.1.0-2'
  source_url 'https://github.com/ggreer/the_silver_searcher/archive/2.1.0.tar.gz'
  source_sha256 'cb416a0da7fe354a009c482ae709692ed567f8e7d2dad4d242e726dd7ca202f0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ag-2.1.0-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ag-2.1.0-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ag-2.1.0-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ag-2.1.0-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ea0d8612843e439f9eae121311d99de52c7ef248ebb418f0999c87f436c64d9b',
     armv7l: 'ea0d8612843e439f9eae121311d99de52c7ef248ebb418f0999c87f436c64d9b',
       i686: 'a2300b669ede04b870da2e2232e0bb888bb49e56a4b9a03d61edb96fae1380f8',
     x86_64: '7a0e7295bb5d28d9b9d620ae1d21823000666cfe32ef203e0055472ab94b726f',
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
