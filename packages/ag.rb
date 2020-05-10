require 'package'

class Ag < Package
  description 'The Silver Searcher. Very fast search similar to ack or grep. (ag)'
  homepage 'https://github.com/ggreer/the_silver_searcher'
  version '2.2.0'
  compatibility 'all'
  source_url 'https://github.com/ggreer/the_silver_searcher/archive/2.2.0.tar.gz'
  source_sha256 '6a0a19ca5e73b2bef9481c29a508d2413ca1a0a9a5a6b1bd9bbd695a7626cbf9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ag-2.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ag-2.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ag-2.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ag-2.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0e6e5a193921c38638a3eeacff917a75cc8651335c783c392053bb825743edcd',
     armv7l: '0e6e5a193921c38638a3eeacff917a75cc8651335c783c392053bb825743edcd',
       i686: 'ea2bb1b33661b58d78ef874a7045f798cb61c54aa2b484987c02822a5f7a8bcf',
     x86_64: 'fb1a37ce5867546e9082763bfa002a180405f2a21b3a51e99899d1c313fe13ad',
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
