require 'package'

class Libxrender < Package
  description 'X Rendering Extension client library.'
  homepage 'http://www.x.org'
  version '0.9.10'
  source_url 'https://www.x.org/releases/individual/lib/libXrender-0.9.10.tar.gz'
  source_sha256 '770527cce42500790433df84ec3521e8bf095dfe5079454a92236494ab296adf'

  depends_on 'pkgconfig' => :build
  depends_on 'renderproto'
  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
