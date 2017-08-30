require 'package'

class Ag < Package
  description 'The Silver Searcher. Very fast search similar to ack or grep. (ag)'
  homepage 'https://github.com/ggreer/the_silver_searcher'
  version '2.1.0'
  source_url 'https://github.com/ggreer/the_silver_searcher/archive/2.1.0.tar.gz'
  source_sha256 'cb416a0da7fe354a009c482ae709692ed567f8e7d2dad4d242e726dd7ca202f0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ag-2.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ag-2.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ag-2.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ag-2.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9068764c9f859f2686bdf26f6a0b30bda895ca53a1daf8779dcf9567a24f047c',
     armv7l: '9068764c9f859f2686bdf26f6a0b30bda895ca53a1daf8779dcf9567a24f047c',
       i686: 'ff04901b182b707cf8215140bc82239b52504c9b1403ba06b3d8ea2935c5b4e5',
     x86_64: 'b9999eb7e207d5794181f112cb06d33d658e232b53385172533dcba91e7b8c43',
  })

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
