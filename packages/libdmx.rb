require 'package'

class Libdmx < Package
  description 'X.org X Window System DMX (Distributed Multihead X) extension library'
  homepage 'http://www.x.org'
  version '1.1.3'
  source_url 'https://www.x.org/archive/individual/lib/libdmx-1.1.3.tar.gz'
  source_sha256 'c4b24d7e13e5a67ead7a18f0b4cc9b7b5363c9d04cd01b83b5122ff92b3b4996'

  depends_on 'xextproto'
  depends_on 'dmxproto'
  depends_on 'libxext'
  depends_on 'libx11'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end