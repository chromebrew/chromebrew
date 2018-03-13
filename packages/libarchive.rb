require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'http://www.libarchive.org/'
  version '3.3.2'
  source_url 'http://www.libarchive.org/downloads/libarchive-3.3.2.tar.gz'
  source_sha256 'ed2dbd6954792b2c054ccf8ec4b330a54b85904a80cef477a1c74643ddafa0ce'



  depends_on 'acl'
  depends_on 'attr'
  depends_on 'lz4'
  depends_on 'xzutils' => :build

  def self.build
    system "./configure \
          --prefix=#{CREW_PREFIX} \
          --libdir=#{CREW_LIB_PREFIX} \    
          --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
