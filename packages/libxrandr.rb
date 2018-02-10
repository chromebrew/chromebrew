require 'package'

class Libxrandr < Package
  description 'X.org X Resize, Rotate and Reflection extension library'
  homepage 'http://www.x.org'
  version '1.5.1'
  source_url 'https://www.x.org/archive/individual/lib/libXrandr-1.5.1.tar.gz'
  source_sha256 '2baa7fb3eca78fe7e11a09b373ba898b717f7eeba4a4bfd68187e04b4789b0d3'

  depends_on 'libxrender'
  depends_on 'randrproto'
  depends_on 'libx11'
   
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end