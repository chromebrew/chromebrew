require 'package'

class Attr < Package
  description 'Commands for Manipulating Filesystem Extended Attributes.'
  homepage 'http://savannah.nongnu.org/projects/attr'
  version '2.4.48-1'
  compatibility 'all'
  source_url 'http://download.savannah.gnu.org/releases/attr/attr-2.4.48.tar.gz'
  source_sha256 '5ead72b358ec709ed00bbf7a9eaef1654baad937c001c044fe8b74c57f5324e7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/attr-2.4.48-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/attr-2.4.48-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/attr-2.4.48-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/attr-2.4.48-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '28abf6ac96e7cc3a1ba2690781b26d855e2f545a408c5583bda3220a8985cbf1',
     armv7l: '28abf6ac96e7cc3a1ba2690781b26d855e2f545a408c5583bda3220a8985cbf1',
       i686: 'cc277ad1091fe6b3c5fcd81dd3894f6b24c021b8fe0daab772577cdd1f473ed5',
     x86_64: '744f97cd27716fcb2f4cb127971e61744fda9ae499479480aef7f6fa5a3c60af',
  })

  depends_on 'gettext'

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
