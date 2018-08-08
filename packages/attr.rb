require 'package'

class Attr < Package
  description 'Commands for Manipulating Filesystem Extended Attributes.'
  homepage 'http://savannah.nongnu.org/projects/attr'
  version '2.4.48'
  source_url 'http://download.savannah.gnu.org/releases/attr/attr-2.4.48.tar.gz'
  source_sha256 '5ead72b358ec709ed00bbf7a9eaef1654baad937c001c044fe8b74c57f5324e7'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gettext'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-am"
  end
end
